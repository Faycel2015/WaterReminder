//
//  WaterHistoryViewModel.swift
//  WaterReminder
//
//  Created by FayTek on 2/24/25.
//

import SwiftUI
import CoreData
import Charts

class WaterHistoryViewModel: ObservableObject {
    @Published var waterIntakes: [WaterIntake] = []
    private let context = PersistenceController.shared.container.viewContext
    
    init() {
        fetchWaterIntake()
    }
    
    func fetchWaterIntake() {
        let request: NSFetchRequest<WaterIntakeEntity> = WaterIntakeEntity.fetchRequest()
        request.sortDescriptors = [NSSortDescriptor(keyPath: \#keyPath(WaterIntakeEntity.timestamp), ascending: false)]
        
        do {
            let results = try context.fetch(request)
            self.waterIntakes = results.map { WaterIntake(id: $0.id ?? UUID(), amount: $0.amount, timestamp: $0.timestamp ?? Date()) }
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
