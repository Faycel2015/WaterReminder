//
//  HealthKitManager.swift
//  WaterReminder
//
//  Created by FayTek on 2/24/25.
//

import SwiftUI
import CoreData
import UserNotifications
import HealthKit

class HealthKitManager {
    static let shared = HealthKitManager()
    private var healthStore = HKHealthStore()
    
    let waterType = HKQuantityType.quantityType(forIdentifier: .dietaryWater)!
    
    func requestAuthorization(completion: @escaping (Bool, Error?) -> Void) {
        let typesToWrite: Set = [waterType]
        let typesToRead: Set = [waterType]
        
        healthStore.requestAuthorization(toShare: typesToWrite, read: typesToRead) { success, error in
            completion(success, error)
        }
    }
    
    func logWaterIntake(amount: Double, completion: @escaping (Bool, Error?) -> Void) {
        let quantity = HKQuantity(unit: .liter(), doubleValue: amount / 1000)
        let sample = HKQuantitySample(type: waterType, quantity: quantity, start: Date(), end: Date())
        
        healthStore.save(sample) { success, error in
            completion(success, error)
        }
    }
    
    func fetchWaterIntake(completion: @escaping (Double?, Error?) -> Void) {
        let startDate = Calendar.current.startOfDay(for: Date())
        let predicate = HKQuery.predicateForSamples(withStart: startDate, end: Date(), options: .strictStartDate)
        
        let query = HKStatisticsQuery(quantityType: waterType, quantitySamplePredicate: predicate, options: .cumulativeSum) { _, result, error in
            guard let sum = result?.sumQuantity() else {
                completion(nil, error)
                return
            }
            completion(sum.doubleValue(for: .liter()) * 1000, nil) // Convert to ml
        }
        
        healthStore.execute(query)
    }
}
