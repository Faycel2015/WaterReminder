//
//  ReminderViewModel.swift
//  WaterReminder
//
//  Created by FayTek on 2/15/25.
//

import SwiftUI
import CoreData
import UserNotifications

class ReminderViewModel: ObservableObject {
    @Published var reminders: [ReminderSettings] = []
    private let context: NSManagedObjectContext

    init(context: NSManagedObjectContext) {
        self.context = context
        fetchReminders()
    }

    func fetchReminders() {
        let request: NSFetchRequest<ReminderSettings> = ReminderSettings.fetchRequest()
        do {
            reminders = try context.fetch(request)
        } catch {
            print("Error fetching reminders: \(error)")
        }
    }

    // Add, toggle, and delete reminders (as implemented in Phase 2).
}
