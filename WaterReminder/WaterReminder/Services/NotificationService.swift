//
//  NotificationService.swift
//  WaterReminder
//
//  Created by FayTek on 2/15/25.
//

import UserNotifications

class NotificationService {
    static let shared = NotificationService()

    func requestAuthorization() {
        UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .sound]) { granted, error in
            if let error = error {
                print("Error requesting notification permissions: \(error)")
            }
        }
    }

    func scheduleNotification(for reminder: ReminderSettings) {
        let content = UNMutableNotificationContent()
        content.title = "Hydration Reminder"
        content.body = reminder.message
        content.sound = .default
        let trigger = UNCalendarNotificationTrigger(
            dateMatching: Calendar.current
                .dateComponents([.hour, .minute], from: reminder.time),
            repeats: true
        )
        let request = UNNotificationRequest(identifier: reminder.objectID.uriRepresentation().absoluteString, content: content, trigger: trigger)
        UNUserNotificationCenter.current().add(request) { error in
            if let error = error {
                print("Error scheduling notification: \(error)")
            }
        }
    }

    func cancelNotification(for reminder: ReminderSettings) {
        UNUserNotificationCenter.current().removePendingNotificationRequests(withIdentifiers: [reminder.objectID.uriRepresentation().absoluteString])
    }
}
