//
//  WaterIntake.swift
//  WaterReminder
//
//  Created by FayTek on 2/24/25.
//

import SwiftUI
import SwiftData

@Model // ✅ SwiftData model instead of Core Data
class WaterIntake {
    var id: UUID
    var amount: Double // Stored in ml
    var timestamp: Date
    
    init(id: UUID = UUID(), amount: Double, timestamp: Date = Date()) {
        self.id = id
        self.amount = amount
        self.timestamp = timestamp
    }
}
