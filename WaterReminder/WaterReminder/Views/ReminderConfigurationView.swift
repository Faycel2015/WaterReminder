//
//   ReminderConfigurationView.swift
//  WaterReminder
//
//  Created by FayTek on 2/15/25.
//

import SwiftUI

struct ReminderConfigurationView: View {
    @Environment(\.managedObjectContext) private var viewContext
    @StateObject private var viewModel: ReminderViewModel
    @State private var showAddReminderSheet = false
    @State private var selectedReminder: ReminderSettings?

    init(viewModel: ReminderViewModel) {
        _viewModel = StateObject(wrappedValue: viewModel)
    }

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
                        selectedReminder = nil
                        showAddReminderSheet = true
                    } label: {
                        Image(systemName: "plus")
                    }
                }
            }
            .sheet(isPresented: $showAddReminderSheet) {
                if let selectedReminder = selectedReminder {
                    ReminderRow(reminder: selectedReminder, viewModel: viewModel)
                } else {
                    Text("Add New Reminder") // Replace with your actual view for adding a new reminder
                }
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
                set: { _ in
                    viewModel.toggleReminder(reminder: reminder)
                }
            )) {
                EmptyView()
            }
            .labelsHidden()
        }
    }
}
