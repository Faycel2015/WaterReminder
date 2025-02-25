//
//  ReminderSettings.swift
//  WaterReminder
//
//  Created by FayTek on 2/24/25.
//

import SwiftUI

class ReminderSettings {
    var id: UUID = UUID()
    var time: Date
    var message: String
    
    init(time: Date, message: String) {
        self.time = time
        self.message = message
    }
}
