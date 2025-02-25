//
//  SkinUnlockHistoryView.swift
//  WaterReminder
//
//  Created by FayTek on 2/25/25.
//

import SwiftUI

struct SkinUnlockHistoryView: View {
    @EnvironmentObject var waterPetVM: WaterPetViewModel
    
    var body: some View {
        VStack(alignment: .leading) {
            Text("Unlocked Skins History")
                .font(.headline)
                .padding(.bottom, 5)
            
            List(waterPetVM.pet.skinUnlockHistory.keys.sorted(), id: \ .self) { skin in
                HStack {
                    Image(systemName: skin)
                        .resizable()
                        .scaledToFit()
                        .frame(width: 30, height: 30)
                    
                    VStack(alignment: .leading) {
                        Text(skin)
                            .font(.headline)
                        if let date = waterPetVM.pet.skinUnlockHistory[skin] {
                            Text("Unlocked on: \(formattedDate(date))")
                                .font(.caption)
                                .foregroundColor(.gray)
                        }
                    }
                }
            }
        }
        .padding()
    }
    
    func formattedDate(_ date: Date) -> String {
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        return formatter.string(from: date)
    }
}
