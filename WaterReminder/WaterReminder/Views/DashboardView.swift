//
//  DashboardView.swift
//  WaterReminder
//
//  Created by FayTek on 2/24/25.
//

import SwiftUI

struct DashboardView: View {
    @Environment(\ .colorScheme) var colorScheme
    @AppStorage("selectedTheme") private var selectedTheme: AppTheme = AppTheme.getSeasonalTheme()
    @EnvironmentObject var waterIntakeVM: WaterIntakeViewModel
    @EnvironmentObject var userProfileVM: UserProfileViewModel
    @EnvironmentObject var waterPetVM: WaterPetViewModel

    var body: some View {
        ZStack {
            DynamicBackgroundView()
            VStack {
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
                
                Spacer()
                
                Picker("Select Theme", selection: $selectedTheme) {
                    ForEach(AppTheme.allCases, id: \ .self) { theme in
                        Text(theme.rawValue.capitalized).tag(theme)
                    }
                }
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
                    .pickerStyle(SegmentedPickerStyle())
                }
                .padding()
                
                Spacer()
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
        DashboardView()
            .preferredColorScheme(.dark)
        DashboardView()
            .preferredColorScheme(.light)
    }
}
