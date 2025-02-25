//
//  ReminderViewModel.swift
//  WaterReminder
//
//  Created by FayTek on 2/24/25.
//

import SwiftUI

class ReminderViewModel: ObservableObject {
    @Published var reminders: [ReminderSettings] = []
}
