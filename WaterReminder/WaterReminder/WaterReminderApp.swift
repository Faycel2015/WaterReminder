//
//  WaterReminderApp.swift
//  WaterReminder
//
//  Created by FayTek on 2/15/25.
//

import SwiftUI
import SwiftData
import UserNotifications
import AVFoundation
import GameKit
import SpriteKit

@main
struct WaterReminderApp: App {
    @UIApplicationDelegateAdaptor(AppDelegate.self) var appDelegate
    
    var body: some Scene {
        WindowGroup {
            DashboardView()
                .preferredColorScheme(.automatic)
                .environmentObject(WaterIntakeViewModel())
                .environmentObject(ReminderViewModel())
                .environmentObject(HistoryViewModel())
                .environmentObject(UserProfileViewModel())
                .environmentObject(WaterPetViewModel())
                .environmentObject(HydrationChallengeViewModel())
                .environmentObject(MultiplayerBattleViewModel())
        }
    }
}
