//
//  SettingsView.swift
//  WaterReminder
//
//  Created by FayTek on 2/15/25.
//

import SwiftUI

struct SettingsView: View {
    @Environment(\.managedObjectContext) private var viewContext

    var body: some View {
        NavigationView {
            List {
                NavigationLink(destination: ReminderConfigurationView(viewModel: ReminderViewModel(context: viewContext))) {
                    Text("Reminder Configuration")
                }

                NavigationLink(
                    destination: AchievementsView(viewModel: WaterIntakeViewModel(context: viewContext))) {
                    Text("Achievements")
                }
            }
            .navigationTitle("Settings")
        }
    }
}
