//
//  AppTheme.swift
//  WaterReminder
//
//  Created by FayTek on 2/25/25.
//

import SwiftUI

enum AppTheme: String, CaseIterable {
    case sunrise, ocean, galaxy, winter, autumn, spring
    
    var gradientColors: [Color] {
        switch self {
        case .sunrise:
            return [Color.orange.opacity(0.8), Color.pink.opacity(0.6)]
        case .ocean:
            return [Color.blue.opacity(0.8), Color.cyan.opacity(0.6)]
        case .galaxy:
            return [Color.purple.opacity(0.8), Color.indigo.opacity(0.6)]
        case .winter:
            return [Color.blue.opacity(0.7), Color.white.opacity(0.8)]
        case .autumn:
            return [Color.red.opacity(0.7), Color.orange.opacity(0.6)]
        case .spring:
            return [Color.green.opacity(0.7), Color.pink.opacity(0.6)]
        }
    }
    
    static func getSeasonalTheme() -> AppTheme {
        let month = Calendar.current.component(.month, from: Date())
        switch month {
        case 12, 1, 2:
            return .winter
        case 3, 4, 5:
            return .spring
        case 6, 7, 8:
            return .ocean
        case 9, 10, 11:
            return .autumn
        default:
            return .ocean
        }
    }
}
