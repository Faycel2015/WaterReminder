//
//  DynamicBackgroundView.swift
//  WaterReminder
//
//  Created by FayTek on 2/25/25.
//

import SwiftUI

struct DynamicBackgroundView: View {
    @State private var animateGradient = false
    @AppStorage("selectedTheme") private var selectedTheme: AppTheme = AppTheme.getSeasonalTheme()
    
    var body: some View {
        LinearGradient(gradient: Gradient(colors: selectedTheme.gradientColors),
                       startPoint: .topLeading, endPoint: .bottomTrailing)
        .ignoresSafeArea()
        .onAppear {
            withAnimation(.easeInOut(duration: 5).repeatForever(autoreverses: true)) {
                animateGradient.toggle()
            }
        }
    }
}
