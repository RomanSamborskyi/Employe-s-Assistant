//
//  ContentView.swift
//  Employe's Assistant
//
//  Created by Roman Samborskyi on 01.12.2023.
//

import SwiftUI

struct ContentView: View {
    
    @State private var selectedTab: Tabs = .months
    @AppStorage("showOnboarding") private var showOnboarding: Bool = true
    @StateObject var svm: SettingsViewModel = SettingsViewModel()
    
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
            SettingsMainView(vm: svm)
                .tag(selectedTab == .settings)
                .tabItem {
                    Label("Settings", systemImage: "gear")
                }
        }.accentColor(svm.newAccentColor)
            .fullScreenCover(isPresented: $showOnboarding) {
                OnboardingMainView(hideOnboarding: $showOnboarding)
            }
    }
}

#Preview {
    ContentView()
}
