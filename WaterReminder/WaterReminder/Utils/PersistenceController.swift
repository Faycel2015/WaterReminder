//
//  PersistenceController.swift
//  WaterReminder
//
//  Created by FayTek on 2/15/25.
//

import SwiftUI
import SwiftData

@MainActor
class PersistenceController {
    static let shared = PersistenceController()
    
    let container: ModelContainer
    
    private init() {
        do {
            container = try ModelContainer(for: WaterIntake.self)
        } catch {
            fatalError("Failed to initialize SwiftData ModelContainer: \(error)")
        }
    }
    
    func save(context: ModelContext) {
        do {
            try context.save()
        } catch {
            print("Error saving SwiftData: \(error.localizedDescription)")
        }
    }
}
