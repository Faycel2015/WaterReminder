//
//  AchievementsView.swift
//  WaterReminder
//
//  Created by FayTek on 2/15/25.
//

import SwiftUI

struct AchievementsView: View {
    @ObservedObject var viewModel: WaterIntakeViewModel

    var body: some View {
        VStack {
            Text("Achievements")
                .font(.largeTitle)

            LazyVGrid(columns: Array(repeating: GridItem(), count: 3)) {
                ForEach(getAchievements(), id: \.self) { achievement in
                    ZStack {
                        Circle()
                            .fill(Color.blue.opacity(0.3))
                            .frame(width: 80, height: 80)
                        Text(achievement)
                            .font(.headline)
                    }
                }
            }
        }
    }

    private func getAchievements() -> [String] {
        var achievements: [String] = []
        if viewModel.calculateStreak() >= 7 {
            achievements.append("7-Day Streak")
        }
        if viewModel.calculateStreak() >= 30 {
            achievements.append("30-Day Streak")
        }
        if viewModel.totalIntake >= 10000 {
            achievements.append("10L Drinker")
        }
        return achievements
    }
}
