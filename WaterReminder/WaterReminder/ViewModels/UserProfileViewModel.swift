//
//  UserProfileViewModel.swift
//  WaterReminder
//
//  Created by FayTek on 2/24/25.
//

import SwiftUI
import SwiftData
import UserNotifications
import AVFoundation
import GameKit
import SpriteKit

class UserProfileViewModel: ObservableObject {
    @AppStorage("selectedAvatar") var selectedAvatar: AvatarType = .robot
    @AppStorage("hydrationStreak") var hydrationStreak: Int = 0
    @Published var showUnlockAnimation: Bool = false
    @Published var showConfetti: Bool = false
    private var audioPlayer: AVAudioPlayer?
    
    var availableAvatars: [AvatarType] {
        return AvatarType.unlockableAvatars(for: hydrationStreak)
    }
    
    func checkForNewUnlocks() {
        if availableAvatars.contains(selectedAvatar) == false {
            selectedAvatar = availableAvatars.last ?? .robot
            showUnlockAnimation = true
            if hydrationStreak >= 60 {
                showConfetti = true
                playConfettiSound()
                DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                    self.showConfetti = false
                }
            }
        }
    }
    
    func playConfettiSound() {
        if let soundURL = Bundle.main.url(forResource: "confetti_sound", withExtension: "mp3") {
            do {
                audioPlayer = try AVAudioPlayer(contentsOf: soundURL)
                audioPlayer?.play()
            } catch {
                print("Error playing confetti sound: \(error.localizedDescription)")
            }
        }
    }
}
