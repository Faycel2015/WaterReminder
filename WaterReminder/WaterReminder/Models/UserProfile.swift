//
//  UserProfile.swift
//  WaterReminder
//
//  Created by FayTek on 2/24/25.
//

import SwiftUI
import AVFoundation

class UserProfile: ObservableObject { // 👈 Fix: Conform to ObservableObject
    @Published var dailyGoal: Double = 2000.0
    @Published var measurementUnit: String = "ml"
    @Published var xp: Int = 0
    @Published var level: Int = 1
    @Published var badges: [String] = []
    @Published var streak: Int = 0 // 👈 Fix: Now properly linked to ViewModel
    @Published var lastLoggedDate: Date?
    
    func addXP(amount: Int) {
        let bonusMultiplier = streak >= 7 ? 2 : 1
        xp += amount * bonusMultiplier
        if xp >= level * 100 {
            xp = 0
            levelUp()
        }
    }
    
    private func levelUp() {
        level += 1
        checkForNewBadges()
        playLevelUpSound()
    }
    
    private func checkForNewBadges() {
        if level == 5 {
            badges.append("Hydration Novice")
        } else if level == 10 {
            badges.append("Water Warrior")
        } else if level == 20 {
            badges.append("Hydration Master")
        }
    }
    
    func updateStreak() {
        let calendar = Calendar.current
        if let lastDate = lastLoggedDate {
            if calendar.isDateInYesterday(lastDate) {
                streak += 1
            } else if !calendar.isDateInToday(lastDate) {
                streak = 0
            }
        } else {
            streak = 1
        }
        lastLoggedDate = Date()
    }
    
    private func playLevelUpSound() {
        if let soundURL = Bundle.main.url(forResource: "level-up", withExtension: "mp3") {
            var player: AVAudioPlayer?
            do {
                player = try AVAudioPlayer(contentsOf: soundURL)
                player?.play()
            } catch {
                print("Error playing sound: \(error.localizedDescription)")
            }
        }
    }
}
