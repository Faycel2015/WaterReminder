//
//  MainDashboard.swift
//  WaterReminder
//
//  Created by FayTek on 2/15/25.
//

import SwiftUI
import CoreData

struct MainDashboard: View {
    @Environment(\ManagedObjectContext) private var viewContext
    @StateObject private var viewModel: WaterIntakeViewModel
    
    init(context: NSManagedObjectContext) {
        _viewModel = StateObject(wrappedValue: WaterIntakeViewModel(context: context))
    }
    
    var body: some View {
        NavigationView {
            VStack(spacing: 20) {
                LiquidProgressView(progress: viewModel.progress)
                QuickAddButtons(viewModel: viewModel)
                TodaySummary(viewModel: viewModel)
                NextReminderView(viewModel: viewModel)
            }
            .padding()
            .navigationTitle("Stay Hydrated")
        }
    }
}

struct LiquidProgressView: View {
    let progress: CGFloat

    var body: some View {
        ZStack {
            Circle()
                .stroke(Color.blue.opacity(0.3), lineWidth: 15)
                .frame(width: 150, height: 150)
            Circle()
                .trim(from: 0, to: progress)
                .stroke(Color.blue, style: StrokeStyle(lineWidth: 15, lineCap: .round))
                .rotationEffect(.degrees(-90))
                .animation(.easeInOut, value: progress)
                .frame(width: 150, height: 150)
            Text("\(Int(progress * 100))%")
                .font(.title)
                .foregroundColor(.blue)
        }
    }
}

struct QuickAddButtons: View {
    let viewModel: WaterIntakeViewModel

    var body: some View {
        HStack {
            ForEach([250, 500, 750], id: \.self) { amount in
                Button(action: {
                    viewModel.addWater(amount: Double(amount), unit: "ml")
                }) {
                    Text("\(amount) ml")
                        .padding()
                        .background(Color.blue)
                        .foregroundColor(.white)
                        .cornerRadius(10)
                }
            }
        }
    }
}

struct TodaySummary: View {
    let viewModel: WaterIntakeViewModel

    var body: some View {
        VStack(alignment: .leading) {
            Text("Today's Intake")
                .font(.headline)
            Text("\(viewModel.totalIntake) ml")
                .font(.largeTitle)
        }
    }
}

struct NextReminderView: View {
    let viewModel: WaterIntakeViewModel

    var body: some View {
        if let nextReminder = viewModel.nextReminder {
            Text("Next Reminder: \(nextReminder)")
                .font(.subheadline)
        } else {
            Text("No reminders scheduled.")
                .font(.subheadline)
        }
    }
}
