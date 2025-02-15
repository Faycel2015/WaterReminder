//
//  HistoryView.swift
//  WaterReminder
//
//  Created by FayTek on 2/15/25.
//

import SwiftUI

struct HistoryView: View {
    @Environment(\.managedObjectContext) private var viewContext
    @StateObject private var viewModel = WaterIntakeViewModel(context: viewContext)

    var body: some View {
        NavigationView {
            List {
                CalendarSection(viewModel: viewModel)
                RecentIntakeSection(viewModel: viewModel)
            }
            .navigationTitle("History")
        }
    }
}

struct CalendarSection: View {
    let viewModel: WaterIntakeViewModel

    var body: some View {
        Section(header: Text("Calendar")) {
            DatePicker("Select Date", selection: $viewModel.selectedDate, displayedComponents: .date)
                .labelsHidden()
            Text("Total Intake: \(viewModel.getDailyIntake(for: viewModel.selectedDate)) ml")
                .font(.headline)
        }
    }
}

struct RecentIntakeSection: View {
    let viewModel: WaterIntakeViewModel

    var body: some View {
        Section(header: Text("Recent Intake")) {
            ForEach(viewModel.waterIntakes.reversed()) { intake in
                HStack {
                    Text(
                        intake.timestamp
                            .formatted(date: .numeric, time: .shortened)
                    )
                    Spacer()
                    Text("\(intake.amount) \(intake.unit ?? "ml")")
                }
            }
        }
    }
}
