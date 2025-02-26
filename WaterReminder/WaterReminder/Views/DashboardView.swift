//
//  DashboardView.swift
//  WaterReminder
//
//  Created by FayTek on 2/24/25.
//

import SwiftUI
import SwiftData

struct DashboardView: View {
    @Environment(\.colorScheme) var colorScheme
    @AppStorage("hasSeenOnboarding") private var hasSeenOnboarding: Bool = false
    @AppStorage("selectedTheme") private var selectedTheme: AppTheme = AppTheme.getSeasonalTheme()
    @Environment(\.modelContext) private var modelContext // ✅ Use Environment for SwiftData
    @State private var waterIntakeVM: WaterIntakeViewModel // ✅ Use @State instead of EnvironmentObject
    @State private var userProfileVM: UserProfileViewModel // ✅ Added UserProfileViewModel
    @State private var waterPetVM: WaterPetViewModel // ✅ Added WaterPetViewModel
    
    init(context: ModelContext) { // ✅ Inject ModelContext in init
        self._waterIntakeVM = State(initialValue: WaterIntakeViewModel(context: context))
        self._userProfileVM = State(initialValue: UserProfileViewModel())
        self._waterPetVM = State(initialValue: WaterPetViewModel())
    }

    var body: some View {
        ZStack {
            DynamicBackgroundView()

            VStack {
                if !hasSeenOnboarding {
                    ContentView(context: modelContext) // ✅ Pass context to ContentView
                    Button("Continue to Dashboard") {
                        hasSeenOnboarding = true
                    }
                    .buttonStyle(.borderedProminent)
                    .padding()
                } else {
                    Text("💧 Water Reminder")
                        .font(.largeTitle)
                        .bold()
                        .foregroundColor(colorScheme == .dark ? .white : .black)
                        .padding()

                    NavigationLink(destination: AvatarSelectionView()) {
                        Text("Customize Avatar")
                            .font(.headline)
                            .padding()
                            .frame(maxWidth: .infinity)
                            .background(Color.blue)
                            .foregroundColor(.white)
                            .cornerRadius(10)
                            .shadow(radius: 5)
                    }
                    .padding()

                    WaterPetView()
                        .padding()

                    ZStack {
                        Circle()
                            .trim(from: 0.0, to: min(1.0, Double(waterIntakeVM.waterIntakes.reduce(0) { $0 + $1.amount }) / waterIntakeVM.dailyGoal))
                            .stroke(Color.blue, lineWidth: 20)
                            .rotationEffect(.degrees(-90))
                            .animation(.easeOut, value: waterIntakeVM.waterIntakes.count)
                            .frame(width: 150, height: 150)

                        Text("\(Int(waterIntakeVM.waterIntakes.reduce(0) { $0 + $1.amount })) / \(Int(waterIntakeVM.dailyGoal)) ml")
                            .font(.title2)
                            .bold()
                    }
                    .padding()
                    
                    Text("Streak: \(userProfileVM.userProfile.streak) days")
                        .font(.headline)
                        .foregroundColor(userProfileVM.userProfile.streak >= 7 ? .orange : .green)
                        .padding()

                    ProgressView(value: Double(userProfileVM.userProfile.xp), total: Double(userProfileVM.userProfile.level * 100))
                        .progressViewStyle(LinearProgressViewStyle())
                        .padding()

                    Text("Level \(userProfileVM.userProfile.level)")
                        .font(.headline)
                        .foregroundColor(.blue)
                        .padding()

                    HStack(spacing: 20) {
                        Button("+250ml") {
                            waterIntakeVM.addWater(amount: 250)
                            waterPetVM.feedPet()
                        }
                        .buttonStyle(.borderedProminent)

                        Button("+500ml") {
                            waterIntakeVM.addWater(amount: 500)
                            waterPetVM.feedPet()
                        }
                        .buttonStyle(.borderedProminent)
                    }
                    .padding()

                    Spacer()
                }
            }
        }
        .onAppear {
            selectedTheme = AppTheme.getSeasonalTheme()
        }
    }
}

// MARK: - Preview
struct DashboardView_Previews: PreviewProvider {
    static var previews: some View {
        DashboardView(context: try! ModelContainer(for: WaterIntake.self).mainContext) // ✅ Inject ModelContext in preview
            .preferredColorScheme(.dark)
        DashboardView(context: try! ModelContainer(for: WaterIntake.self).mainContext) // ✅ Inject ModelContext in preview
            .preferredColorScheme(.light)
    }
}
