//
//  WaterHistoryView.swift
//  WaterReminder
//
//  Created by FayTek on 2/24/25.
//

import SwiftUI
import CoreData
import Charts

struct WaterHistoryView: View {
    @StateObject private var viewModel = WaterHistoryViewModel()
    
    var body: some View {
        VStack {
            Text("Water Intake History")
                .font(.title)
                .padding()
            
            Text("Daily Average: \(Int(viewModel.dailyAverageIntake())) ml")
                .font(.headline)
                .padding()
                .foregroundColor(.blue)
            
            Chart(viewModel.weeklyIntakeSummary()) { data in
                BarMark(
                    x: .value("Date", data.date, unit: .day),
                    y: .value("Amount", data.amount)
                )
                .foregroundStyle(.blue)
                .annotation(position: .top) {
                    Text("\(Int(data.amount)) ml")
                        .font(.caption)
                        .foregroundColor(.primary)
                }
            }
            .frame(height: 300)
            .padding()
            
            List(viewModel.waterIntakes) { intake in
                HStack {
                    Text("\(Int(intake.amount)) ml")
                        .font(.headline)
                    Spacer()
                    VStack(alignment: .trailing) {
                        Text(intake.timestamp, style: .date)
                            .font(.subheadline)
                            .foregroundColor(.gray)
                        Text(intake.timestamp, style: .time)
                            .font(.footnote)
                            .foregroundColor(.gray)
                    }
                }
            }
        }
        .onAppear {
            viewModel.fetchWaterIntake()
        }
    }
}

struct ChartData: Identifiable {
    let id = UUID()
    let date: Date
    let amount: Double
}

struct WaterHistoryView_Previews: PreviewProvider {
    static var previews: some View {
        WaterHistoryView()
    }
}
