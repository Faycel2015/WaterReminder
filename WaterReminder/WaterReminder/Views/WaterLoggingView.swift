//
//  WaterLoggingView.swift
//  WaterReminder
//
//  Created by FayTek on 2/24/25.
//

import SwiftUI
import AVFoundation
import SpriteKit

struct WaterLoggingView: View {
    @State private var fillAmount: CGFloat = 0.0
    @State private var selectedBottle: String = "Glass Bottle"
    @State private var waterTemperature: String = "Cold"
    @State private var showRippleEffect = false
    private var player: AVAudioPlayer?
    
    let bottleOptions = ["Glass Bottle", "Sports Bottle", "Plastic Bottle", "Metal Flask"]
    let temperatureOptions = ["Cold", "Normal", "Hot"]
    let bottleSounds = [
        "Glass Bottle": "glass_pour",
        "Sports Bottle": "sports_pour",
        "Plastic Bottle": "plastic_pour",
        "Metal Flask": "metal_pour"
    ]
    
    var body: some View {
        VStack {
            Text("💧 Hydration Progress")
                .font(.title2)
                .bold()
                .padding()
            
            Picker("Select Bottle", selection: $selectedBottle) {
                ForEach(bottleOptions, id: \ .self) { bottle in
                    Text(bottle).tag(bottle)
                }
            }
            .pickerStyle(SegmentedPickerStyle())
            .padding()
            
            Picker("Select Temperature", selection: $waterTemperature) {
                ForEach(temperatureOptions, id: \ .self) { temp in
                    Text(temp).tag(temp)
                }
            }
            .pickerStyle(SegmentedPickerStyle())
            .padding()
            
            ZStack {
                RoundedRectangle(cornerRadius: 25)
                    .stroke(Color.blue, lineWidth: 4)
                    .frame(width: 150, height: 300)
                    .overlay(
                        GeometryReader { geometry in
                            VStack {
                                Spacer()
                                Rectangle()
                                    .fill(LinearGradient(gradient: Gradient(colors: [Color.blue.opacity(0.8), Color.blue]), startPoint: .top, endPoint: .bottom))
                                    .frame(height: geometry.size.height * fillAmount)
                                    .cornerRadius(25)
                                    .animation(.easeInOut(duration: 1), value: fillAmount)
                            }
                        }
                    )
                
                
                ZStack {
                    SpriteView(scene: WaterScene(), options: [.allowsTransparency])
                        .frame(width: 150, height: 300)
                        .cornerRadius(25)
                if showRippleEffect {
                    Circle()
                        .stroke(Color.blue.opacity(0.5), lineWidth: 3)
                        .frame(width: 80, height: 80)
                        .scaleEffect(1.5)
                        .opacity(0)
                        .animation(Animation.easeOut(duration: 1).repeatCount(1, autoreverses: false), value: showRippleEffect)
                }
            }
            .padding()
            
            Button("+250ml") {
                logWater(amount: 0.125) // 250ml is 12.5% of a 2L goal
            }
            .buttonStyle(.borderedProminent)
            .padding()
            
            Button("+500ml") {
                logWater(amount: 0.25)
            }
            .buttonStyle(.borderedProminent)
            .padding()
        }
    }
    
    func logWater(amount: CGFloat) {
        fillAmount = min(fillAmount + amount, 1.0)
        playPouringSound()
        UIImpactFeedbackGenerator(style: .medium).impactOccurred()
        triggerRippleEffect()
    }
    
    func playPouringSound() {
        if let soundName = bottleSounds[selectedBottle], let soundURL = Bundle.main.url(forResource: soundName, withExtension: "mp3") {
            do {
                let player = try AVAudioPlayer(contentsOf: soundURL)
                player.play()
            } catch {
                print("Error playing sound: \(error.localizedDescription)")
            }
        }
    }
    
    func triggerRippleEffect() {
        showRippleEffect = true
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            showRippleEffect = false
        }
    }
}

// MARK: - Preview
struct WaterLoggingView_Previews: PreviewProvider {
    static var previews: some View {
        WaterLoggingView()
    }
}
