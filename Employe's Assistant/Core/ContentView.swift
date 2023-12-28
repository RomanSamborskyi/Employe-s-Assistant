//
//  ContentView.swift
//  Employe's Assistant
//
//  Created by Roman Samborskyi on 01.12.2023.
//

import SwiftUI

struct ContentView: View {
 
    @State private var selectedTab: Tabs = .months
    @StateObject private var svm: SettingsViewModel = SettingsViewModel()
    
    var body: some View {
        TabView {
            MonthsMainView()
                .tag(selectedTab == .months)
                .tabItem {
                    Label("Months", systemImage: "calendar.badge.clock.rtl")
                }
            StatisticMainView()
                .tag(selectedTab == .statistic)
                .tabItem {
                    Label("Statistic", systemImage: "chart.xyaxis.line")
                }
            SettingsMainView()
                .tag(selectedTab == .settings)
                .tabItem {
                    Label("Settings", systemImage: "gear")
                }
        }.accentColor(svm.newAccentColor)
    }
}

#Preview {
    ContentView()
}
