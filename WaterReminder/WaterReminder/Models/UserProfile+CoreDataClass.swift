//
//  UserProfile+CoreDataClass.swift
//  WaterReminder
//
//  Created by FayTek on 2/15/25.
//

import Foundation
import CoreData

public class UserProfile: NSManagedObject {
    @NSManaged public var weight: Double
    @NSManaged public var activityLevel: String
    @NSManaged public var climate: String
    @NSManaged public var dailyGoal: Double
    @NSManaged public var measurementSystem: String
}
