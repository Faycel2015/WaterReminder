//
//  LeaderboardView.swift
//  WaterReminder
//
//  Created by FayTek on 2/25/25.
//

import SwiftUI

struct LeaderboardView: View {
    @EnvironmentObject var challengeVM: HydrationChallengeViewModel
    
    var body: some View {
        VStack {
            Text("🏆 Hydration Leaderboard")
                .font(.title2)
                .bold()
                .padding()
            
            List(challengeVM.leaderboard) { entry in
                HStack {
                    Text(entry.name)
                        .fontWeight(entry.name == "You" ? .bold : .regular)
                    Spacer()
                    Text("\(entry.score) ml")
                        .foregroundColor(.blue)
                }
                .padding(.vertical, 5)
            }
            .frame(height: 200)
            
            // ✅ Safely unwrap dailyChallenge
            if let daily = challengeVM.dailyChallenge {
                Text("Daily Challenge: \(Int(daily.progress))/\(Int(daily.goal)) ml")
                    .font(.subheadline)
                    .padding()
                ProgressView(value: daily.progress, total: daily.goal)
                    .progressViewStyle(LinearProgressViewStyle())
                    .padding()
            } else {
                Text("Daily Challenge: Loading...")
                    .font(.subheadline)
                    .padding()
            }
            
            // ✅ Safely unwrap weeklyChallenge
            if let weekly = challengeVM.weeklyChallenge {
                Text("Weekly Challenge: \(Int(weekly.progress))/\(Int(weekly.goal)) ml")
                    .font(.subheadline)
                    .padding()
                ProgressView(value: weekly.progress, total: weekly.goal)
                    .progressViewStyle(LinearProgressViewStyle())
                    .padding()
            } else {
                Text("Weekly Challenge: Loading...")
                    .font(.subheadline)
                    .padding()
            }
        }
        .padding()
    }
}

