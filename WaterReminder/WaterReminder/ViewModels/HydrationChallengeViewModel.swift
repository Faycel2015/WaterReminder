//
//  HydrationChallengeViewModel.swift
//  WaterReminder
//
//  Created by FayTek on 2/25/25.
//

import SwiftUI
import SwiftData
import GameKit

class HydrationChallengeViewModel: ObservableObject { // ✅ Use ObservableObject
    private var modelContext: ModelContext // ✅ Inject ModelContext
    @Published var dailyChallenge: HydrationChallenge?
    @Published var weeklyChallenge: HydrationChallenge?
    @Published var leaderboard: [LeaderboardEntry] = []
    private var localPlayer = GKLocalPlayer.local
    
    init(context: ModelContext) { // ✅ Inject ModelContext
        self.modelContext = context
        loadChallenges()
        loadLeaderboardData()
    }
    
    private func loadChallenges() {
        let fetchDescriptor = FetchDescriptor<HydrationChallenge>()
        do {
            let storedChallenges = try modelContext.fetch(fetchDescriptor)
            
            if let daily = storedChallenges.first(where: { $0.type == "Daily" }) {
                self.dailyChallenge = daily
            } else {
                let newDaily = HydrationChallenge(type: "Daily", goal: 2000)
                modelContext.insert(newDaily)
                self.dailyChallenge = newDaily
            }
            
            if let weekly = storedChallenges.first(where: { $0.type == "Weekly" }) {
                self.weeklyChallenge = weekly
            } else {
                let newWeekly = HydrationChallenge(type: "Weekly", goal: 14000)
                modelContext.insert(newWeekly)
                self.weeklyChallenge = newWeekly
            }
            
            try? modelContext.save() // ✅ Save new challenges if needed
        } catch {
            print("Error fetching challenges: \(error.localizedDescription)")
        }
    }
    
    func updateChallengeProgress(amount: Double) {
        dailyChallenge?.updateProgress(amount: amount)
        weeklyChallenge?.updateProgress(amount: amount)
        try? modelContext.save() // ✅ Persist changes
        submitScoreToGameCenter(score: Int(dailyChallenge?.progress ?? 0))
    }
    
    func authenticateGameCenter() {
        localPlayer.authenticateHandler = { viewController, error in
            if let viewController = viewController {
                if let scene = UIApplication.shared.connectedScenes.first as? UIWindowScene,
                   let window = scene.windows.first {
                    window.rootViewController?.present(viewController, animated: true)
                }
            } else if self.localPlayer.isAuthenticated {
                print("Game Center authentication successful")
            } else if let error = error {
                print("Game Center authentication failed: \(error.localizedDescription)")
            }
        }
    }
    
    func submitScoreToGameCenter(score: Int) {
        let leaderboardID = "hydration_leaderboard"
        
        GKLeaderboard.submitScore(
            score,
            context: 0,
            player: GKLocalPlayer.local,
            leaderboardIDs: [leaderboardID]
        ) { error in
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
