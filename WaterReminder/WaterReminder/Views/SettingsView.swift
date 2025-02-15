//
//  SettingsView.swift
//  WaterReminder
//
//  Created by FayTek on 2/15/25.
//

import SwiftUI

struct SettingsView: View {
    var body: some View {
        NavigationView {
            List {
                NavigationLink(destination: ReminderConfigurationView()) {
                    Text("Reminder Configuration")
                }
                
                NavigationLink(destination: AchievementsView(viewModel: WaterIntakeViewModel)) {
                    Text("Achievements")
                }
            }
            .navigationTitle("Settings")
        }
    }
}

struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsView()
    }
}
