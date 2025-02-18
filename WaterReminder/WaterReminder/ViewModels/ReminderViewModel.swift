//
//  ReminderViewModel.swift
//  WaterReminder
//
//  Created by FayTek on 2/15/25.
//

import CoreData
import SwiftUI
import UserNotifications

class ReminderViewModel: ObservableObject {
    private let notificationCenter = UNUserNotificationCenter.current()
    private let context: NSManagedObjectContext
    
    @Published var reminders: [ReminderSettings] = []
    
    init(context: NSManagedObjectContext) {
        self.context = context
        fetchReminders()
    }
    
    func fetchReminders() {
        let fetchRequest: NSFetchRequest<ReminderSettings> = ReminderSettings.fetchRequest() as! NSFetchRequest<ReminderSettings>
        do {
            reminders = try context.fetch(fetchRequest)
        } catch {
            print("Failed to fetch reminders: \(error.localizedDescription)")
        }
    }
    
    func addReminder(time: Date, message: String) -> ReminderSettings {
        let reminder = ReminderSettings(context: context)
        reminder.id = UUID()
        reminder.time = time
        reminder.message = message
        reminder.isActive = true
        
        saveContext()
        scheduleNotification(for: reminder)
        fetchReminders()
        return reminder
    }
    
    func toggleReminder(reminder: ReminderSettings) {
        reminder.isActive.toggle()
        
        if reminder.isActive {
            scheduleNotification(for: reminder)
        } else {
            if let id = reminder.id?.uuidString {
                removeNotification(id: id)
            }
        }
        
        saveContext()
        fetchReminders()
    }
    
    func deleteReminder(reminder: ReminderSettings) {
        if let id = reminder.id?.uuidString {
            removeNotification(id: id)
        }
        
        context.delete(reminder)
        saveContext()
        fetchReminders()
    }
    
    func deleteReminders(at offsets: IndexSet) {
        for index in offsets {
            let reminder = reminders[index]
            deleteReminder(reminder: reminder)
        }
    }
    
    func requestAuthorization() {
        NotificationService.shared.requestAuthorization()
    }
    
    private func scheduleNotification(for reminder: ReminderSettings) {
        guard let id = reminder.id?.uuidString else {
            print("Reminder ID is missing. Cannot schedule notification.")
            return
        }
        
        let content = UNMutableNotificationContent()
        content.title = "Water Reminder"
        content.body = reminder.message
        content.sound = .default
        
        let trigger = UNCalendarNotificationTrigger(
            dateMatching: Calendar.current.dateComponents([.hour, .minute], from: reminder.time),
            repeats: false
        )
        
        let request = UNNotificationRequest(identifier: id, content: content, trigger: trigger)
        
        notificationCenter.add(request) { error in
            if let error = error {
                print("Error scheduling reminder notification: \(error.localizedDescription)")
            } else {
                print("Successfully scheduled reminder with ID: \(id)")
            }
        }
    }
    
    private func removeNotification(id: String) {
        notificationCenter.removePendingNotificationRequests(withIdentifiers: [id])
        print("Removed pending notification with ID: \(id)")
    }
    
    private func saveContext() {
        do {
            try context.save()
        } catch {
            print("Failed to save Core Data context: \(error.localizedDescription)")
        }
    }
}
