//
//  MultiplayerBattleViewModel.swift
//  WaterReminder
//
//  Created by FayTek on 2/25/25.
//

import SwiftUI
import SwiftData
import GameKit

class MultiplayerBattleViewModel: ObservableObject {
    @Published var battle = MultiplayerBattle()
    private var matchmakerVC: GKMatchmakerViewController?
    
    func startMatchmaking() {
        let request = GKMatchRequest()
        request.minPlayers = 2
        request.maxPlayers = 4
        matchmakerVC = GKMatchmakerViewController(matchRequest: request)
        matchmakerVC?.matchmakerDelegate = self
    }
    
    func applyPenaltyToPlayer(player: String) {
        battle.applyPenalty(for: player)
    }
    
    func activatePowerUpForPlayer(player: String) {
        battle.activatePowerUp(for: player)
    }
}

extension MultiplayerBattleViewModel: GKMatchmakerViewControllerDelegate {
    func matchmakerViewController(_ viewController: GKMatchmakerViewController, didFind match: GKMatch) {
        viewController.dismiss(animated: true)
        battle.startBattle(with: match)
    }
    
    func matchmakerViewControllerWasCancelled(_ viewController: GKMatchmakerViewController) {
        viewController.dismiss(animated: true)
    }
    
    func matchmakerViewController(_ viewController: GKMatchmakerViewController, didFailWithError error: Error) {
        print("Matchmaking failed: \(error.localizedDescription)")
    }
}
