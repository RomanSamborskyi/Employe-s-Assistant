//
//  ContentView.swift
//  Employe's Assistant
//
//  Created by Roman Samborskyi on 01.12.2023.
//

import SwiftUI

struct ContentView: View {
    
    @State private var selectedTab: Tabs = .months
    @State var hideTabBar: Bool = false
    @AppStorage("showOnboarding") private var showOnboarding: Bool = true
    @State var dataManager: DataManager = DataManager()
    
    var body: some View {
        if #available(iOS 17.0, *) {
            ZStack {
                switch selectedTab {
                case .months:
                    MonthsMainView(hideTabBar: $hideTabBar, dataManager: dataManager)
                case .statistic:
                    StatisticMainView(dataManager: dataManager)
                case .settings:
                    SettingsMainView(dataManager: dataManager, hideTabBar: $hideTabBar)
                }
                if !hideTabBar {
                CustomTabBar(currentTab: $selectedTab)
                        .transition(.move(edge: .bottom))
                }
            }
            .tint(Color.newAccentColor)
            .fullScreenCover(isPresented: $showOnboarding) {
                OnboardingMainView(dataManager: dataManager)
            }
        } else {
            TabView {
                MonthsMainView(hideTabBar: $hideTabBar, dataManager: dataManager)
                    .tabItem {
                        Label("Months", systemImage: "calendar.badge.clock.rtl")
                    }
                StatisticMainView(dataManager: dataManager)
                    .tag(selectedTab == .statistic)
                    .tabItem {
                        Label("Statistic", systemImage: "chart.xyaxis.line")
                    }
                    
                SettingsMainView(dataManager: dataManager, hideTabBar: $hideTabBar)
                    .tag(selectedTab == .settings)
                    .tabItem {
                        Label("Settings", systemImage: "gear")
                    }
            }
            .tint(Color.newAccentColor)
            .fullScreenCover(isPresented: $showOnboarding) {
                OnboardingMainView(dataManager: dataManager)
            }
        }
    }
}

#Preview {
    ContentView()
}
