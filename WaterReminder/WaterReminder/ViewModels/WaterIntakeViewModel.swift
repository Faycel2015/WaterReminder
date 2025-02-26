//
//  WaterIntakeViewModel.swift
//  WaterReminder
//
//  Created by FayTek on 2/24/25.
//

import SwiftUI
import SwiftData

@Observable // ✅ Use @Observable instead of @ObservableObject
class WaterIntakeViewModel {
    var waterIntakes: [WaterIntake] = [] // ✅ Remove @Published
    var dailyGoal: Double = 2000.0 // ✅ Remove @Published
    var totalIntake: Double = 0.0 // ✅ Remove @Published
    
    private var modelContext: ModelContext

    init(context: ModelContext) { // ✅ Inject ModelContext
        self.modelContext = context
        fetchWaterIntake()
    }

    func addWater(amount: Double) {
        let newIntake = WaterIntake(amount: amount)
        modelContext.insert(newIntake)
        waterIntakes.append(newIntake)
        totalIntake += amount
    }

    func fetchWaterIntake() {
        let fetchDescriptor = FetchDescriptor<WaterIntake>(sortBy: [SortDescriptor(\.timestamp, order: .reverse)])
        do {
            self.waterIntakes = try modelContext.fetch(fetchDescriptor)
            self.totalIntake = waterIntakes.reduce(0) { $0 + $1.amount }
        } catch {
            print("Error fetching water intake: \(error.localizedDescription)")
        }
    }
}

