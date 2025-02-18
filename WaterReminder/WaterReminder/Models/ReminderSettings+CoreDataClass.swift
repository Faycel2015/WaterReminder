//
//  ReminderSettings+CoreDataClass.swift
//  WaterReminder
//
//  Created by FayTek on 2/15/25.
//

import Foundation
import CoreData

@objc(ReminderSettings) // Ensure the class name matches the entity name in Core Data
public class ReminderSettings: NSManagedObject {
    @NSManaged public var id: UUID?
    @NSManaged public var time: Date
    @NSManaged public var message: String
    @NSManaged public var isActive: Bool
}

// Extend ReminderSettings to conform to Identifiable
extension ReminderSettings: Identifiable {
    // Provide a computed property for the 'id' if it's optional
    public var wrappedId: UUID {
        id ?? UUID() // Provide a default value if 'id' is nil
    }
}
