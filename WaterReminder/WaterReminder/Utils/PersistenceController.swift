//
//  PersistenceController.swift
//  WaterReminder
//
//  Created by FayTek on 2/15/25.
//

import CoreData

class PersistenceController {
    static let shared = PersistenceController()
    
    let container: NSPersistentContainer
    
    init() {
        container = NSPersistentContainer(name: "WaterReminderModel")
        container.loadPersistentStores { _, error in
            if let error = error as NSError? {
                print("Error loading persistent store: \(error), \(error.userInfo)")
            }
        }
    }
    
    func save() {
        let context = container.viewContext
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                print("Error saving Core Data: \(error.localizedDescription)")
            }
        }
    }
}
