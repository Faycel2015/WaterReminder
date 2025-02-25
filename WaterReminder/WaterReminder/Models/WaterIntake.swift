//
//  WaterIntake.swift
//  WaterReminder
//
//  Created by FayTek on 2/24/25.
//

import SwiftUI

class WaterIntake {
    var id: UUID = UUID()
    var amount: Double
    var timestamp: Date = Date()
    
    init(amount: Double) {
        self.amount = amount
    }
}
