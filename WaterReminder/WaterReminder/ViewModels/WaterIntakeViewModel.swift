//
//  WaterIntakeViewModel.swift
//  WaterReminder
//
//  Created by FayTek on 2/15/25.
//

import SwiftUI
import CoreData

class WaterIntakeViewModel: ObservableObject {
    @Published var totalIntake: Double = 0
    @Published var dailyGoal: Double = 2000
    @Published var progress: CGFloat = 0
    @Published var waterIntakes: [WaterIntake] = []
    @Published var selectedDate: Date = Date()
    @Published var nextReminder: Date?
    private let context: NSManagedObjectContext
    
    init(context: NSManagedObjectContext, dailyGoal: Double = 2000) {
        self.context = context
        self.dailyGoal = dailyGoal
        fetchWaterIntakes()
    }
    
    func updateNextReminder() {
        let futureReminders = waterIntakes.filter { $0.timestamp > Date() }
        nextReminder = futureReminders.sorted(by: { $0.timestamp < $1.timestamp }).first?.timestamp
    }
    
    func fetchWaterIntakes() {
        let request = NSFetchRequest<WaterIntake>(entityName: "WaterIntake")
        do {
            waterIntakes = try context.fetch(request)
            calculateTotalIntake()
            updateNextReminder()
        } catch {
            print("Error fetching water intakes: \(error.localizedDescription)")
        }
    }
    
    func addWater(amount: Double, unit: String) {
        let convertedAmount: Double
        switch unit.lowercased() {
        case "oz":
            convertedAmount = amount * 29.5735
        default:
            convertedAmount = amount
        }
        
        let newIntake = WaterIntake(context: context)
        newIntake.amount = convertedAmount
        newIntake.unit = "ml"
        newIntake.timestamp = Date()
        saveContext()
        calculateTotalIntake()
        updateNextReminder()
    }
    
    func deleteWaterIntake(_ intake: WaterIntake) {
        context.delete(intake)
        saveContext()
        fetchWaterIntakes()
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
        progress = dailyGoal > 0 ? CGFloat(totalIntake / dailyGoal) : 0
    }
    
    func calculateStreak() -> Int {
        var streak = 0
        var currentDate = Date()
        while true {
            let dailyIntake = getDailyIntake(for: currentDate)
            if dailyIntake >= dailyGoal {
                streak += 1
            } else {
                break
            }
            currentDate = Calendar.current.date(byAdding: .day, value: -1, to: currentDate)!
        }
        return streak
    }
    
    private func saveContext() {
        do {
            try context.save()
        } catch {
            print("Error saving context: \(error.localizedDescription)")
        }
    }
}
