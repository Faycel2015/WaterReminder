//
//  WaterPetView.swift
//  WaterReminder
//
//  Created by FayTek on 2/25/25.
//

import SwiftUI

struct WaterPetView: View {
    @EnvironmentObject var waterPetVM: WaterPetViewModel
    let availableSkins = ["fish.fill", "tortoise.fill", "leaf.fill", "star.fill"]
    
    var body: some View {
        VStack {
            Text("Your Water Pet")
                .font(.headline)
                .padding(.bottom, 5)
            
            Image(systemName: waterPetVM.pet.selectedSkin)
                .resizable()
                .scaledToFit()
                .frame(width: 100, height: 100)
                .animation(.spring(), value: waterPetVM.pet.growthStage)
                .onTapGesture {
                    waterPetVM.playWithPet()
                }
                
            Text(petMoodText())
                .font(.subheadline)
                .foregroundColor(.gray)
                
            Picker("Choose Pet Skin", selection: $waterPetVM.pet.selectedSkin) {
                ForEach(availableSkins, id: \ .self) { skin in
                    Text(skin).tag(skin)
                }
            }
            .pickerStyle(MenuPickerStyle())
            .onChange(of: waterPetVM.pet.selectedSkin) { oldSkin, newSkin in
                waterPetVM.changePetSkin(to: newSkin)
            }
        }
    }
    
    func petMoodText() -> String {
        if waterPetVM.pet.happiness <= 3 {
            return "Your pet is sad 😢"
        } else if waterPetVM.pet.happiness >= 7 {
            return "Your pet is happy! 😊"
        } else {
            return "Your pet is okay 🙂"
        }
    }
}
