//
//  WaterReminderApp.swift
//  WaterReminder
//
//  Created by FayTek on 2/15/25.
//

import SwiftUI
import SwiftData

@main
struct WaterReminderApp: App {
    @UIApplicationDelegateAdaptor(AppDelegate.self) var appDelegate
    @AppStorage("hasSeenOnboarding") private var hasSeenOnboarding: Bool = false

    // ✅ Correctly initialize ModelContainer
    private let modelContainer: ModelContainer

    init() {
        do {
            modelContainer = try ModelContainer(for: WaterIntake.self, HydrationChallenge.self)
        } catch {
            fatalError("Failed to initialize ModelContainer: \(error)")
        }
    }

    var body: some Scene {
        WindowGroup {
            ContentView(context: modelContainer.mainContext) // ✅ Pass ModelContext
                .preferredColorScheme(.light)
                .modelContainer(modelContainer) // ✅ Attach ModelContainer
                .environment(WaterIntakeViewModel(context: modelContainer.mainContext))
                .environment(WaterHistoryViewModel(context: modelContainer.mainContext))
                .environmentObject(ReminderViewModel())
                .environmentObject(UserProfileViewModel())
                .environmentObject(WaterPetViewModel())
                .environmentObject(HydrationChallengeViewModel(context: modelContainer.mainContext)) // ✅ Inject ModelContext
                .environmentObject(MultiplayerBattleViewModel())
        }
    }
}
