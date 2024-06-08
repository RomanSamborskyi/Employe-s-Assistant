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
    
    var body: some View {
        if #available(iOS 17.0, *) {
            ZStack {
                switch selectedTab {
                case .months:
                    MonthsMainView()
                case .statistic:
                    StatisticMainView()
                case .settings:
                    SettingsMainView()
                }
            
                CustomTabBar(currentTab: $selectedTab)
            }
            .tint(Color.newAccentColor)
            .fullScreenCover(isPresented: $showOnboarding) {
                    OnboardingMainView()
            }
        } else {
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
            }
            .tint(Color.newAccentColor)
            .fullScreenCover(isPresented: $showOnboarding) {
                    OnboardingMainView()
            }
        }
    }
}

#Preview {
    ContentView()
}
