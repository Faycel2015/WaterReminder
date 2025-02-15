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

    var body: some View {
        NavigationView {
            List {
                ForEach(viewModel.reminders) { reminder in
                    ReminderRow(reminder: reminder, viewModel: viewModel)
                }
                .onDelete { indexSet in
                    indexSet.forEach { index in
                        viewModel.deleteReminder(reminder: viewModel.reminders[index])
                    }
                }
            }
            .navigationTitle("Reminders")
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button(action: {
                        showAddReminderSheet = true
                    }) {
                        Image(systemName: "plus")
                    }
                }
            }
            .sheet(isPresented: $showAddReminderSheet) {
                AddReminderView(viewModel: viewModel)
            }
        }
        .onAppear {
            viewModel.requestAuthorization()
        }
    }

    @State private var showAddReminderSheet = false
}

struct ReminderRow: View {
    let reminder: ReminderSettings
    let viewModel: ReminderViewModel

    var body: some View {
        HStack {
            Text(
                reminder.time.formatted(date: .omitted, time: .shortened) ?? ""
            )
            Spacer()
            Toggle(isOn: Binding(get: { reminder.isActive }, set: { newValue in
                viewModel.toggleReminder(reminder: reminder)
            })) {
                EmptyView()
            }
            .labelsHidden()
        }
    }
}
