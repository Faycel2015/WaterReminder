//
//  StatisticsView.swift
//  WaterReminder
//
//  Created by FayTek on 2/15/25.
//

import SwiftUI
import SwiftData
import Charts

struct StatisticsView: View {
    @Environment(\.managedObjectContext) private var viewContext
    @StateObject private var viewModel = WaterIntakeViewModel(context: viewContext)

    var body: some View {
        NavigationView {
            ScrollView {
                DailyChartSection(viewModel: viewModel)
                WeeklyChartSection(viewModel: viewModel)
                StreakSection(viewModel: viewModel)
            }
            .padding()
            .navigationTitle("Statistics")
        }
    }
}

struct DailyChartSection: View {
    let viewModel: WaterIntakeViewModel

    var body: some View {
        ChartSection(title: "Daily Intake", data: viewModel.getWeeklyIntake(for: Date()))
    }
}

struct WeeklyChartSection: View {
    let viewModel: WaterIntakeViewModel

    var body: some View {
        ChartSection(title: "Weekly Intake", data: viewModel.getMonthlyIntake(for: Date()))
    }
}

struct ChartSection: View {
    let title: String
    let data: [Double]

    var body: some View {
        VStack(alignment: .leading) {
            Text(title)
                .font(.headline)
            Chart {
                ForEach(data.enumerated(), id: \.offset) { index, value in
                    BarMark(
                        x: .value("Day", index + 1),
                        y: .value("Intake", value)
                    )
                }
            }
            .chartYAxis(.hidden)
            .frame(height: 200)
        }
    }
}

struct StreakSection: View {
    let viewModel: WaterIntakeViewModel

    var body: some View {
        VStack(alignment: .leading) {
            Text("Streak")
                .font(.headline)
            HStack {
                Image(systemName: "flame.fill")
                    .foregroundColor(.orange)
                Text("\(viewModel.calculateStreak()) Days")
                    .font(.title)
            }
        }
    }
}
