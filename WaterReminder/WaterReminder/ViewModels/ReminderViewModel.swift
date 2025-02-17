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
    let notificationCenter = UNUserNotificationCenter.current()
    
    func addReminder(time: Date, message: String) {
        let content = UNMutableNotificationContent()
        content.title = "Water Reminder"
        content.body = message
        content.sound = .default
        
        let trigger = UNCalendarNotificationTrigger(dateMatching: Calendar.current.dateComponents([.hour, .minute], from: time), repeats: false)
        let request = UNNotificationRequest(identifier: UUID().uuidString, content: content, trigger: trigger)
        
        notificationCenter.add(request) { error in
            if let error = error {
                print("Error scheduling reminder: \(error)")
            }
        }
    }
}
