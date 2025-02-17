//
//  HistoryView.swift
//  WaterReminder
//
//  Created by FayTek on 2/15/25.
//

import SwiftUI
import CoreData

struct HistoryView: View {
    @Environment(\ManagedObjectContext) private var viewContext
    @StateObject private var viewModel: WaterIntakeViewModel
    
    init(context: NSManagedObjectContext) {
        _viewModel = StateObject(wrappedValue: WaterIntakeViewModel(context: context))
    }
    
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
    @State private var selectedDate = Date()
    let viewModel: WaterIntakeViewModel
    
    var body: some View {
        Section(header: Text("Calendar")) {
            DatePicker("Select Date", selection: $selectedDate, displayedComponents: .date)
                .labelsHidden()
            Text("Total Intake: \(viewModel.getDailyIntake(for: selectedDate)) ml")
                .font(.headline)
        }
    }
}

struct RecentIntakeSection: View {
    let viewModel: WaterIntakeViewModel
    
    var body: some View {
        Section(header: Text("Recent Intake")) {
            ForEach(viewModel.waterIntakes.reversed(), id: \ .self) { intake in
                HStack {
                    Text(intake.timestamp?.formatted(date: .numeric, time: .shortened) ?? "")
                    Spacer()
                    Text("\(intake.amount) \(intake.unit ?? \"ml\")")
                }
            }
        }
    }
}
