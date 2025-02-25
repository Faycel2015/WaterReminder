//
//  AvatarSelectionView.swift
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

struct AvatarSelectionView: View {
    @EnvironmentObject var userProfile: UserProfileViewModel
    
    var body: some View {
        ZStack {
            VStack {
                Text("Select Your Avatar")
                    .font(.title)
                    .bold()
                    .padding()
                
                ZStack {
                    Image(userProfile.selectedAvatar.imageName)
                        .resizable()
                        .scaledToFit()
                        .frame(width: 150, height: 150)
                        .clipShape(Circle())
                        .overlay(
                            Circle()
                                .stroke(userProfile.selectedAvatar.isRare ? Color.yellow : Color.blue, lineWidth: 3)
                        )
                        .shadow(color: userProfile.selectedAvatar.isRare ? Color.yellow.opacity(0.8) : Color.clear, radius: 10)
                        .padding()
                        .scaleEffect(userProfile.showUnlockAnimation ? 1.3 : 1.0)
                        .animation(.spring(response: 0.5, dampingFraction: 0.5, blendDuration: 1), value: userProfile.showUnlockAnimation)
                }
                .onAppear {
                    userProfile.checkForNewUnlocks()
                    DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
                        userProfile.showUnlockAnimation = false
                    }
                }
                
                Picker("Avatar", selection: $userProfile.selectedAvatar) {
                    ForEach(userProfile.availableAvatars, id: \ .self) { avatar in
                        Text(avatar.rawValue.capitalized).tag(avatar)
                    }
                }
                .pickerStyle(WheelPickerStyle())
                .padding()
                
                Text("Current Hydration Streak: \(userProfile.hydrationStreak) Days")
                    .font(.headline)
                    .padding()
                
                Spacer()
            }
            
            if userProfile.showConfetti {
                ConfettiView()
                    .edgesIgnoringSafeArea(.all)
            }
        }
    }
}

// MARK: - Preview
struct AvatarSelectionView_Previews: PreviewProvider {
    static var previews: some View {
        AvatarSelectionView()
            .environmentObject(UserProfileViewModel())
    }
}
