//
//  WaterIntakeViewModel.swift
//  WaterReminder
//
//  Created by FayTek on 2/24/25.
//

import CoreData
import SwiftUI
import UserNotifications

class WaterIntakeViewModel: ObservableObject {
    @Published var waterIntakes: [WaterIntake] = []
    @Published var dailyGoal: Double = 2000.0 // Default goal in ml
    @Published var totalIntake: Double = 0.0

    private let context = PersistenceController.shared.container.viewContext

    init() {
        fetchWaterIntake()
    }

    func addWater(amount: Double) {
        let newIntake = WaterIntake(id: UUID(), amount: amount, timestamp: Date())
        waterIntakes.append(newIntake)
        totalIntake += amount
        saveToCoreData(amount: amount)
        
    }

    private func saveToCoreData(amount: Double) {
        let intake = WaterIntakeEntity(context: context)
        intake.id = UUID()
        intake.amount = amount
        intake.timestamp = Date()

        do {
            try context.save()
        } catch {
            print("Error saving water intake: \(error.localizedDescription)")
        }

        func fetchWaterIntake() {
            let request: NSFetchRequest<WaterIntakeEntity> = WaterIntakeEntity.fetchRequest()
            request.sortDescriptors = [NSSortDescriptor(keyPath: \#keyPath(WaterIntakeEntity.timestamp), ascending: false)]

            do {
                let results = try context.fetch(request)
                waterIntakes = results.map { WaterIntake(id: $0.id ?? UUID(), amount: $0.amount, timestamp: $0.timestamp ?? Date()) }
                totalIntake = waterIntakes.reduce(0) { $0 + $1.amount }
            } catch {
                print("Error fetching water intake: \(error.localizedDescription)")
            }
        }
    }
}
