//
//  ContentView.swift
//  WaterReminder
//
//  Created by FayTek on 2/15/25.
//

import SwiftUI
import SwiftData

struct ContentView: View {
    @State private var viewModel: WaterIntakeViewModel // ✅ Use @State instead of @StateObject
    
    init(context: ModelContext) {
        self._viewModel = State(initialValue: WaterIntakeViewModel(context: context)) // ✅ Inject ModelContext
    }

    var body: some View {
        NavigationView {
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
}
