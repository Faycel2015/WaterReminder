//
//  WaterIntakeViewModel.swift
//  WaterReminder
//
//  Created by FayTek on 2/15/25.
//

import Foundation
import SwiftUI
import CoreData

class WaterIntakeViewModel: ObservableObject {
    @Published var totalIntake: Double = 0
    @Published var dailyGoal: Double = 2000
    @Published var progress: CGFloat = 0
    @Published var waterIntakes: [WaterIntake] = []
    @Published var selectedDate: Date = Date()

    private let context: NSManagedObjectContext

    init(context: NSManagedObjectContext) {
        self.context = context
        fetchWaterIntakes()
    }

    func fetchWaterIntakes() {
        let request: NSFetchRequest<WaterIntake> = WaterIntake.fetchRequest()
        do {
            waterIntakes = try context.fetch(request)
            calculateTotalIntake()
        } catch {
            print("Error fetching water intakes: \(error)")
        }
    }

    func addWater(amount: Double, unit: String) {
        let newIntake = WaterIntake(context: context)
        newIntake.amount = amount
        newIntake.unit = unit
        newIntake.timestamp = Date()
        saveContext()
        calculateTotalIntake()
    }

    func getDailyIntake(for date: Date) -> Double {
        let startOfDay = Calendar.current.startOfDay(for: date)
        let endOfDay = Calendar.current.date(byAdding: .day, value: 1, to: startOfDay)!
        return waterIntakes
            .filter { $0.timestamp >= startOfDay && $0.timestamp < endOfDay }
            .reduce(0) { $0 + $1.amount }
    }

    func getWeeklyIntake(for date: Date) -> [Double] {
        var result: [Double] = []
        let calendar = Calendar.current
        guard let startOfWeek = calendar.date(from: calendar.dateComponents([.yearForWeekOfYear, .weekOfYear], from: date)) else { return [] }
        for i in 0..<7 {
            if let day = calendar.date(byAdding: .day, value: i, to: startOfWeek) {
                result.append(getDailyIntake(for: day))
            }
        }
        return result
    }

    func getMonthlyIntake(for date: Date) -> [Double] {
        var result: [Double] = []
        let calendar = Calendar.current
        guard let startOfMonth = calendar.date(from: calendar.dateComponents([.year, .month], from: date)) else { return [] }
        guard let endOfMonth = calendar.date(byAdding: DateComponents(month: 1, day: -1), to: startOfMonth) else { return [] }
        let range = calendar.range(of: .day, in: .month, for: startOfMonth)!
        for day in range {
            if let date = calendar.date(byAdding: .day, value: day - 1, to: startOfMonth) {
                result.append(getDailyIntake(for: date))
            }
        }
        return result
    }

    func calculateTotalIntake() {
        totalIntake = waterIntakes.reduce(0) { $0 + $1.amount }
        progress = CGFloat(totalIntake / dailyGoal)
    }

    func calculateStreak() -> Int {
        var streak = 0
        var currentDate = Date()
        while getDailyIntake(for: currentDate) >= dailyGoal {
            streak += 1
            currentDate = Calendar.current.date(byAdding: .day, value: -1, to: currentDate)!
        }
        return streak
    }

    private func saveContext() {
        do {
            try context.save()
        } catch {
            print("Error saving context: \(error)")
        }
    }
}
