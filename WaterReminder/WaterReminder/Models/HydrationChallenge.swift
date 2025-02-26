//
//  HydrationChallenge.swift
//  WaterReminder
//
//  Created by FayTek on 2/25/25.
//

import SwiftUI
import SwiftData

@Model // ✅ Enable SwiftData persistence
class HydrationChallenge {
    var id: UUID = UUID()
    var type: String // "Daily" or "Weekly"
    var goal: Double // Goal in ml
    var progress: Double = 0.0 // Current progress
    var isCompleted: Bool = false
    
    init(type: String, goal: Double) {
        self.type = type
        self.goal = goal
    }
    
    func updateProgress(amount: Double) {
        progress += amount
        if progress >= goal {
            isCompleted = true
        }
    }
}
