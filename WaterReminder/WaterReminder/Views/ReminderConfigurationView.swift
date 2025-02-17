//
//   ReminderConfigurationView.swift
//  WaterReminder
//
//  Created by FayTek on 2/15/25.
//

import SwiftUI

struct ReminderConfigurationView: View {
    @Environment(\.managedObjectContext) private var viewContext
    @StateObject private var viewModel = ReminderViewModel(context: PersistenceController.shared.container.viewContext)
    @State private var showAddReminderSheet = false

    var body: some View {
        NavigationView {
            List {
                ForEach(viewModel.reminders) { reminder in
                    ReminderRow(reminder: reminder, viewModel: viewModel)
                }
                .onDelete { indexSet in
                    viewModel.deleteReminders(at: indexSet)
                }
            }
            .navigationTitle("Reminders")
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button {
                        showAddReminderSheet = true
                    } label: {
                        Image(systemName: "plus")
                    }
                }
            }
            .sheet(isPresented: $showAddReminderSheet) {
                addReminder(viewModel: viewModel) // Ensure this view exists
            }
        }
        .onAppear {
            viewModel.requestAuthorization()
        }
    }
}

struct ReminderRow: View {
    let reminder: ReminderSettings
    let viewModel: ReminderViewModel

    var body: some View {
        HStack {
            Text(reminder.time.formatted(date: .omitted, time: .shortened))
            Spacer()
            Toggle(isOn: Binding(
                get: { reminder.isActive },
                set: { newValue in
                    viewModel.toggleReminder(reminder: reminder)
                }
            )) {
                EmptyView()
            }
            .labelsHidden()
        }
    }
}
