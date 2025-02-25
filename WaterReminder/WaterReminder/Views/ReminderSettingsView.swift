//
//  ReminderSettingsView.swift
//  WaterReminder
//
//  Created by FayTek on 2/24/25.
//

import SwiftUI

struct ReminderSettingsView: View {
    @State private var reminderTime = Date()
    @State private var reminderMessage = "Time to drink water!"
    
    var body: some View {
        VStack {
            Text("Hydration Reminder Settings")
                .font(.title)
                .padding()
            
            DatePicker("Reminder Time", selection: $reminderTime, displayedComponents: .hourAndMinute)
                .datePickerStyle(WheelDatePickerStyle())
                .padding()
                .overlay(Text("Select the time you want to be reminded to drink water.").font(.caption).foregroundColor(.gray).padding(.top, 5), alignment: .bottom)
            
            TextField("Reminder Message", text: $reminderMessage)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding()
                .onChange(of: reminderMessage) { oldValue, newValue in
                    if newValue.count > 50 {
                        reminderMessage = String(newValue.prefix(50))
                    }
                }
                .overlay(Text("Max 50 characters").font(.caption).foregroundColor(.gray).padding(.top, 5), alignment: .bottom)
            
            Button("Schedule Reminder") {
                NotificationManager.shared.scheduleWaterReminder(at: reminderTime, message: reminderMessage)
                let generator = UINotificationFeedbackGenerator()
                generator.notificationOccurred(.success)
            }
            .buttonStyle(.borderedProminent)
            .padding()
            
            Spacer()
        }
        .padding()
        .onAppear {
            NotificationManager.shared.requestNotificationPermission()
            NotificationManager.shared.addNotificationActions()
        }
    }
}

struct ReminderSettingsView_Previews: PreviewProvider {
    static var previews: some View {
        ReminderSettingsView()
    }
}
