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
            
            Text("Daily Challenge: \(Int(challengeVM.dailyChallenge.progress))/\(Int(challengeVM.dailyChallenge.goal)) ml")
                .font(.subheadline)
                .padding()
            ProgressView(value: challengeVM.dailyChallenge.progress, total: challengeVM.dailyChallenge.goal)
                .progressViewStyle(LinearProgressViewStyle())
                .padding()
            
            Text("Weekly Challenge: \(Int(challengeVM.weeklyChallenge.progress))/\(Int(challengeVM.weeklyChallenge.goal)) ml")
                .font(.subheadline)
                .padding()
            ProgressView(value: challengeVM.weeklyChallenge.progress, total: challengeVM.weeklyChallenge.goal)
                .progressViewStyle(LinearProgressViewStyle())
                .padding()
        }
        .padding()
    }
}
