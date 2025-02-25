//
//  HistoryViewModel.swift
//  WaterReminder
//
//  Created by FayTek on 2/24/25.
//

import SwiftUI

class HistoryViewModel: ObservableObject {
    @Published var waterHistory: [WaterIntake] = []
}
