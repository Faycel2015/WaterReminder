//
//  WaterIntake+CoreDataClass.swift
//  WaterReminder
//
//  Created by FayTek on 2/15/25.
//

import Foundation
import CoreData

public class WaterIntake: NSManagedObject {
    @NSManaged public var amount: Double
    @NSManaged public var unit: String
    @NSManaged public var timestamp: Date
}
