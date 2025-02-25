//
//  WaterPetViewModel.swift
//  WaterReminder
//
//  Created by FayTek on 2/25/25.
//

import SwiftUI
import AVFoundation

class WaterPetViewModel: ObservableObject {
    @Published var pet = WaterPet()
    private var player: AVAudioPlayer?
    
    func feedPet() {
        pet.updateHappiness(drankWater: true)
        playSound(named: "bubble")
        checkAchievements()
    }
    
    func playWithPet() {
        pet.happiness = min(pet.happiness + 2, 10)
        playSound(named: "happy")
    }
    
    func changePetSkin(to skin: String) {
        pet.changeSkin(to: skin)
    }
    
    private func playSound(named soundName: String) {
        if let soundURL = Bundle.main.url(forResource: soundName, withExtension: "mp3") {
            do {
                player = try AVAudioPlayer(contentsOf: soundURL)
                player?.play()
            } catch {
                print("Error playing sound: \(error.localizedDescription)")
            }
        }
    }
    
    private func checkAchievements() {
        if pet.growthStage == 3 {
            pet.unlockSkin("star.fill")
        }
        if pet.happiness == 10 {
            pet.unlockSkin("tortoise.fill")
        }
        pet.checkSeasonalSkins()
        checkChallengeProgress()
    }
    
    func checkChallengeProgress() {
        let specialChallenges: [String: Int] = [
            "fireworks.fill": 30, // 30 days of hydration for Independence Day skin 🎆
            "heart.fill": 20, // 20 days of hydration for Valentine's Day skin ❤️
            "shamrock.fill": 17 // 17 days of hydration for St. Patrick's Day skin ☘️
        ]
        
        for (skin, goal) in specialChallenges {
            pet.updateChallengeProgress(for: skin, goal: goal)
        }
    }
}
