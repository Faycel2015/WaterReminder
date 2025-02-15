//
//  UserProfileViewModel.swift
//  WaterReminder
//
//  Created by FayTek on 2/15/25.
//

import Foundation
import SwiftUI
import CoreData

class UserProfileViewModel: ObservableObject {
    private let persistenceController: PersistenceController
    
    init(persistenceController: PersistenceController) {
        self.persistenceController = persistenceController
    }
    
    func updateProfile(name: String, weight: Double, height: Double, dailyGoal: Double) {
        let context = persistenceController.container.viewContext
        let profile = UserProfile(context: context)
        profile.name = name
        profile.weight = weight
        profile.height = height
        profile.dailyGoal = dailyGoal
        persistenceController.save()
    }
}
