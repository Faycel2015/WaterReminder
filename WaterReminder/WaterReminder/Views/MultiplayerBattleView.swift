//
//  MultiplayerBattleView.swift
//  WaterReminder
//
//  Created by FayTek on 2/25/25.
//

import SwiftUI
import GameKit

struct MultiplayerBattleView: View {
    @EnvironmentObject var battleVM: MultiplayerBattleViewModel
    
    var body: some View {
        VStack {
            Text("💦 Water Battle Arena")
                .font(.title2)
                .bold()
                .padding()
            
            if battleVM.battle.isDoubleXPActive {
                Text("🔥 Double XP Weekend Active! 🔥")
                    .font(.headline)
                    .foregroundColor(.orange)
                    .padding()
            }
            
            if let eventPowerUp = battleVM.battle.eventPowerUp {
                Text("🎁 Special Event: \(eventPowerUp) 🎁")
                    .font(.headline)
                    .foregroundColor(.purple)
                    .padding()
            }
            
            Button("Start Matchmaking") {
                battleVM.startMatchmaking()
            }
            .buttonStyle(.borderedProminent)
            .padding()
            
            List(battleVM.battle.playerScores.sorted(by: { $0.value > $1.value }), id: \ .key) { player, score in
                HStack {
                    Text(player)
                        .fontWeight(.bold)
                    Spacer()
                    Text("\(score) ml")
                        .foregroundColor(.blue)
                }
            }
            .frame(height: 200)
            
            HStack {
                Button("Apply Penalty") {
                    if let localPlayer = GKLocalPlayer.local.alias {
                        battleVM.applyPenaltyToPlayer(player: localPlayer)
                    }
                }
                .buttonStyle(.bordered)
                .padding()
                
                Button("Activate Power-Up") {
                    if let localPlayer = GKLocalPlayer.local.alias {
                        battleVM.activatePowerUpForPlayer(player: localPlayer)
                    }
                }
                .buttonStyle(.borderedProminent)
                .padding()
            }
        }
        .padding()
    }
}
