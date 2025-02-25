//
//  HydrationChallengeViewModel.swift
//  WaterReminder
//
//  Created by FayTek on 2/25/25.
//

import SwiftUI
import SwiftData
import GameKit

class HydrationChallengeViewModel: ObservableObject {
    @Published var dailyChallenge = HydrationChallenge(type: "Daily", goal: 2000)
    @Published var weeklyChallenge = HydrationChallenge(type: "Weekly", goal: 14000)
    @Published var leaderboard: [LeaderboardEntry] = []
    private var localPlayer = GKLocalPlayer.local
    
    init() {
        loadLeaderboardData()
        loadLeaderboardData()
    }
    
    func updateChallengeProgress(amount: Double) {
        dailyChallenge.updateProgress(amount: amount)
        weeklyChallenge.updateProgress(amount: amount)
        submitScoreToGameCenter(score: Int(dailyChallenge.progress))
    }
    
    func authenticateGameCenter() {
        localPlayer.authenticateHandler = { viewController, error in
            if let viewController = viewController {
                UIApplication.shared.windows.first?.rootViewController?.present(viewController, animated: true)
            } else if self.localPlayer.isAuthenticated {
                print("Game Center authentication successful")
            } else if let error = error {
                print("Game Center authentication failed: \(error.localizedDescription)")
            }
        }
    }
    
    func submitScoreToGameCenter(score: Int) {
        let leaderboardID = "hydration_leaderboard"
        let scoreReporter = GKScore(leaderboardIdentifier: leaderboardID)
        scoreReporter.value = Int64(score)
        GKScore.report([scoreReporter]) { error in
            if let error = error {
                print("Error submitting score: \(error.localizedDescription)")
            } else {
                print("Score submitted successfully!")
            }
        }
    }
    
    func loadLeaderboardData() {
        leaderboard = [
            LeaderboardEntry(name: "You", score: Int.random(in: 1000...2000)),
            LeaderboardEntry(name: "Alice", score: Int.random(in: 1500...2500)),
            LeaderboardEntry(name: "Bob", score: Int.random(in: 1200...2300)),
            LeaderboardEntry(name: "Charlie", score: Int.random(in: 1300...2400))
        ].sorted(by: { $0.score > $1.score })
    }
}

struct LeaderboardEntry: Identifiable {
    let id = UUID()
    let name: String
    let score: Int
}
