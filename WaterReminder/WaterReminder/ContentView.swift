//
//  ContentView.swift
//  WaterReminder
//
//  Created by FayTek on 2/15/25.
//

import SwiftUI

struct ContentView: View {
    @Environment(\.managedObjectContext) private var viewContext

    var body: some View {
        MainDashboard(context: viewContext)
    }
}

#Preview {
    ContentView()
}
