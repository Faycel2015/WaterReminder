//
//  WaterPet.swift
//  WaterReminder
//
//  Created by FayTek on 2/25/25.
//

import SwiftUI

class WaterPet {
    var happiness: Int = 5 // 0 = sad, 10 = very happy
    var growthStage: Int = 1 // 1 = baby, 2 = medium, 3 = fully grown
    var lastFedDate: Date?
    var selectedSkin: String = "fish.fill" // Default pet skin
    var unlockedSkins: [String] = ["fish.fill"] // Initially unlocked skin
    var challengeProgress: [String: Int] = [:] // Tracks progress for special challenges
    var skinUnlockHistory: [String: Date] = [:] // Stores when each skin was unlocked
    
    func updateHappiness(drankWater: Bool) {
        let calendar = Calendar.current
        if let lastFed = lastFedDate {
            if !calendar.isDateInToday(lastFed) {
                happiness -= 2
            }
        }
        if drankWater {
            happiness = min(happiness + 1, 10)
            lastFedDate = Date()
            updateGrowth()
        }
    }
    
    private func updateGrowth() {
        if happiness >= 7 {
            growthStage = min(growthStage + 1, 3)
        }
    }
    
    func changeSkin(to newSkin: String) {
        if unlockedSkins.contains(newSkin) {
            selectedSkin = newSkin
        }
    }
    
    func unlockSkin(_ skin: String) {
        if !unlockedSkins.contains(skin) {
            unlockedSkins.append(skin)
            skinUnlockHistory[skin] = Date()
            sendUnlockNotification(skin)
        }
    }
    
    func sendUnlockNotification(_ skin: String) {
        let content = UNMutableNotificationContent()
        content.title = "New Skin Unlocked! 🎉"
        content.body = "You’ve unlocked the \(skin) skin! Go check it out in the pet customization menu."
        content.sound = .default
        
        let request = UNNotificationRequest(identifier: UUID().uuidString, content: content, trigger: nil)
        UNUserNotificationCenter.current().add(request)
    }
    
    func checkSeasonalSkins() {
        let formatter = DateFormatter()
        formatter.dateFormat = "MM-dd"
        let today = formatter.string(from: Date())
        
        let seasonalSkins: [String: String] = [
            "10-31": "pumpkin.fill",    // Halloween 🎃
            "12-25": "snowflake",       // Christmas ❄️
            "02-14": "heart.fill",      // Valentine's Day ❤️
            "07-04": "fireworks.fill",  // Independence Day 🎆
            "04-01": "clown.fill",      // April Fool's 🤡
            "03-17": "shamrock.fill"     // St. Patrick's Day ☘️
        ]
        
        if let skin = seasonalSkins[today] {
            unlockSkin(skin)
        }
    }
    
    func updateChallengeProgress(for skin: String, goal: Int) {
        challengeProgress[skin, default: 0] += 1
        if challengeProgress[skin, default: 0] >= goal {
            unlockSkin(skin)
        }
    }
}
