//
//  WaterReminderApp.swift
//  WaterReminder
//
//  Created by FayTek on 2/15/25.
//

import SwiftUI

@main
struct WaterReminderApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
