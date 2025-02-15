//
//  HealthKitService.swift
//  WaterReminder
//
//  Created by FayTek on 2/15/25.
//

import HealthKit

class HealthKitService {
    let healthStore = HKHealthStore()
    
    func requestAuthorization() {
        let typesToRead = Set([HKObjectType.quantityType(forIdentifier: .dietaryWater)!])
        healthStore.requestAuthorization(toShare: nil, read: typesToRead) { _, _ in }
    }
}
