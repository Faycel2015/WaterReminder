//
//  NotificationManager.swift
//  WaterReminder
//
//  Created by FayTek on 2/24/25.
//

import SwiftUI
import UserNotifications
import CoreHaptics

class NotificationManager {
    static let shared = NotificationManager()
    
    private var lastIntakeTime: Date? = nil
    
    func requestNotificationPermission() {
        UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .badge, .sound]) { granted, error in
            if let error = error {
                print("Error requesting permission: \(error.localizedDescription)")
            }
            print("Notification permission granted: \(granted)")
        }
    }
    
    func scheduleWaterReminder(at time: Date, message: String) {
        let content = UNMutableNotificationContent()
        content.title = "Hydration Reminder"
        content.body = message
        content.sound = .default
        content.categoryIdentifier = "WATER_REMINDER"
        
        let triggerDate = Calendar.current.dateComponents([.hour, .minute], from: time)
        let trigger = UNCalendarNotificationTrigger(dateMatching: triggerDate, repeats: true)
        
        let request = UNNotificationRequest(identifier: UUID().uuidString, content: content, trigger: trigger)
        UNUserNotificationCenter.current().add(request) { error in
            if let error = error {
                print("Error scheduling notification: \(error.localizedDescription)")
            }
        }
    }
    
    func addNotificationActions() {
        let snoozeAction = UNNotificationAction(identifier: "SNOOZE_ACTION", title: "Snooze 10 min", options: [])
        let drinkAction = UNNotificationAction(identifier: "DRINK_ACTION", title: "I Drank Water", options: [.foreground])
        
        let category = UNNotificationCategory(identifier: "WATER_REMINDER", actions: [snoozeAction, drinkAction], intentIdentifiers: [], options: [])
        
        UNUserNotificationCenter.current().setNotificationCategories([category])
    }
    
    func handleNotificationAction(identifier: String) {
        switch identifier {
        case "SNOOZE_ACTION":
            let snoozeTime = Calendar.current.date(byAdding: .minute, value: 10, to: Date()) ?? Date()
            scheduleWaterReminder(at: snoozeTime, message: "Reminder: Stay Hydrated!")
        case "DRINK_ACTION":
            lastIntakeTime = Date()
            scheduleAdaptiveReminder()
            print("User confirmed water intake")
        default:
            break
        }
    }
    
    func scheduleAdaptiveReminder() {
        guard let lastIntake = lastIntakeTime else { return }
        let nextReminderTime = Calendar.current.date(byAdding: .hour, value: 2, to: lastIntake) ?? Date()
        scheduleWaterReminder(at: nextReminderTime, message: "Stay hydrated! It's time for another glass of water.")
    }
}
