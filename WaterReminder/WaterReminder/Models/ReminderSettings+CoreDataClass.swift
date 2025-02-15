//
//  ReminderSettings+CoreDataClass.swift
//  WaterReminder
//
//  Created by FayTek on 2/15/25.
//

import Foundation
import CoreData

public class ReminderSettings: NSManagedObject {
    @NSManaged public var time: Date
    @NSManaged public var message: String
    @NSManaged public var isActive: Bool
}
