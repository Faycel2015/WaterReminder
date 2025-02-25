//
//  MultiplayerBattle.swift
//  WaterReminder
//
//  Created by FayTek on 2/25/25.
//

import SwiftUI
import AVFoundation
import GameKit

class MultiplayerBattle: ObservableObject {
    var match: GKMatch?
    var playerScores: [String: Int] = [:]
    var powerUps: [String: Int] = [:] // Stores power-up effects per player
    var isDoubleXPActive: Bool = false
    var eventPowerUp: String? = nil // Stores active event-based power-up
    
    func startBattle(with match: GKMatch) {
        self.match = match
        playerScores = [:]
        powerUps = [:]
        for player in match.players {
            playerScores[player.alias] = 0
            powerUps[player.alias] = 0
        }
        checkForWeekendPowerUp()
        checkForEventPowerUp()
        sendInitialData()
    }
    
    func updateScore(for player: String, amount: Int) {
        let bonus = powerUps[player, default: 0]
        let multiplier = isDoubleXPActive ? 2 : 1
        playerScores[player, default: 0] += (amount + bonus) * multiplier
        sendScoreUpdate()
    }
    
    func applyPenalty(for player: String) {
        playerScores[player, default: 0] -= 50 // Penalty for missing hydration goal
        sendScoreUpdate()
    }
    
    func activatePowerUp(for player: String) {
        powerUps[player, default: 0] = 50 // Bonus 50 ml for the next hydration log
        sendScoreUpdate()
    }
    
    func checkForWeekendPowerUp() {
        let calendar = Calendar.current
        let today = calendar.component(.weekday, from: Date())
        if today == 7 || today == 1 { // Saturday (7) or Sunday (1)
            isDoubleXPActive = true
        } else {
            isDoubleXPActive = false
        }
    }
    
    func checkForEventPowerUp() {
        let formatter = DateFormatter()
        formatter.dateFormat = "MM-dd"
        let today = formatter.string(from: Date())
        let specialEvents: [String: String] = [
            "12-25": "Holiday Hydration Boost", // Christmas ❄️
            "10-31": "Spooky Hydration", // Halloween 🎃
            "07-04": "Independence Hydration", // Independence Day 🎆
            "01-01": "New Year Boost" // New Year's Day 🎉
        ]
        
        eventPowerUp = specialEvents[today]
    }
    
    func sendInitialData() {
        guard let match = match else { return }
        do {
            let data = try JSONEncoder().encode(playerScores)
            try match.sendData(toAllPlayers: data, with: .reliable)
        } catch {
            print("Error sending initial data: \(error.localizedDescription)")
        }
    }
    
    func sendScoreUpdate() {
        guard let match = match else { return }
        do {
            let data = try JSONEncoder().encode(playerScores)
            try match.sendData(toAllPlayers: data, with: .reliable)
        } catch {
            print("Error sending score update: \(error.localizedDescription)")
        }
    }
}
