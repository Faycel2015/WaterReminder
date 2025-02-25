//
//  WaterTrackerView.swift
//  WaterReminder
//
//  Created by FayTek on 2/24/25.
//

import SwiftUI

struct WaterTrackerView: View {
    @StateObject private var viewModel = WaterIntakeViewModel()
    
    var body: some View {
        VStack {
            Text("Water Tracker")
                .font(.largeTitle)
                .bold()
            
            CircularProgressView(progress: viewModel.totalIntake / viewModel.dailyGoal)
                .frame(width: 200, height: 200)
                
            Text("Total: \(Int(viewModel.totalIntake)) ml")
                .font(.title2)
                .padding()
                
            HStack(spacing: 20) {
                Button(action: { viewModel.addWater(amount: 250) }) {
                    Text("+250ml")
                }
                Button(action: { viewModel.addWater(amount: 500) }) {
                    Text("+500ml")
                }
            }
            .buttonStyle(.borderedProminent)
            
            Spacer()
        }
        .padding()
    }
}

struct CircularProgressView: View {
    let progress: Double
    
    var body: some View {
        ZStack {
            Circle()
                .stroke(lineWidth: 20.0)
                .opacity(0.3)
                .foregroundColor(.blue)
            
            Circle()
                .trim(from: 0.0, to: CGFloat(min(progress, 1.0)))
                .stroke(style: StrokeStyle(lineWidth: 20.0, lineCap: .round))
                .foregroundColor(.blue)
                .rotationEffect(.degrees(-90))
                .animation(.easeOut(duration: 1.0), value: progress)
        }
    }
}

// MARK: - Preview

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        WaterTrackerView()
    }
}
