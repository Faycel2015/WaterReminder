//
//  WaterHistoryViewModel.swift
//  WaterReminder
//
//  Created by FayTek on 2/24/25.
//

import SwiftUI
import SwiftData
import Charts

@Observable // ✅ Use @Observable instead of @ObservableObject
class WaterHistoryViewModel {
    var waterIntakes: [WaterIntake] = [] // ✅ Remove @Published
    private var modelContext: ModelContext

    init(context: ModelContext) { // ✅ Inject ModelContext
        self.modelContext = context
        fetchWaterIntake()
    }

    func fetchWaterIntake() {
        let fetchDescriptor = FetchDescriptor<WaterIntake>(sortBy: [SortDescriptor(\.timestamp, order: .reverse)])
        do {
            self.waterIntakes = try modelContext.fetch(fetchDescriptor)
        } catch {
            print("Error fetching water intake: \(error.localizedDescription)")
        }
    }

    func weeklyIntakeSummary() -> [ChartData] {
        let groupedData = Dictionary(grouping: waterIntakes) { intake in
            Calendar.current.startOfDay(for: intake.timestamp)
        }

        return groupedData.map { (date, intakes) in
            let totalAmount = intakes.reduce(0) { $0 + $1.amount }
            return ChartData(date: date, amount: totalAmount)
        }.sorted { $0.date < $1.date }
    }

    func dailyAverageIntake() -> Double {
        let groupedData = Dictionary(grouping: waterIntakes) { intake in
            Calendar.current.startOfDay(for: intake.timestamp)
        }
        let totalIntake = waterIntakes.reduce(0) { $0 + $1.amount }
        let daysCount = max(groupedData.count, 1) // Avoid division by zero
        return totalIntake / Double(daysCount)
    }
}

