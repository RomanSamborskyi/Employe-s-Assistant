//
//  CustomTabBar.swift
//  Employee's Assistant
//
//  Created by Roman Samborskyi on 03.06.2024.
//

import SwiftUI

struct CustomTabBar: View {
    
    @Binding  var currentTab: Tabs
    @State private var allTabs: [AnimatedTab] = Tabs.allCases.compactMap { tab -> AnimatedTab in
        return .init(tab: tab)
    }
    
    var body: some View {
        if #available(iOS 17.0, *) {
            GeometryReader { proxy in
                VStack {
                    Spacer()
                    ZStack(alignment: .top) {
                        RoundedRectangle(cornerRadius: 0)
                            .frame(maxWidth: .infinity)
                            .frame(height: proxy.size.height / 9)
                            .foregroundStyle(.bar)
                        HStack(spacing: proxy.size.width / 5) {
                            ForEach($allTabs) { $tab in
                                let currentTab = tab.tab
                                VStack {
                                    Image(systemName: currentTab.icon)
                                        .symbolEffect(.bounce, value: tab.isAnimating)
                                        .symbolRenderingMode(.palette)
                                        .foregroundStyle(self.currentTab == currentTab ? Color.newAccentColor.opacity(0.6) : Color.gray, self.currentTab == currentTab ? Color.newAccentColor : Color.gray)
                                        .font(.title2)
                                        .padding(3)
                                    Text(currentTab.description)
                                        .font(.caption2)
                                }
                                .foregroundStyle(self.currentTab == currentTab ? Color.newAccentColor : Color.gray)
                                .onTapGesture {
                                    self.currentTab = currentTab
                                    withAnimation(.bouncy, completionCriteria: .logicallyComplete, {
                                        tab.isAnimating = true
                                    }, completion: {
                                        var transaction = Transaction()
                                        transaction.disablesAnimations = true
                                        withTransaction(transaction) {
                                            tab.isAnimating = nil
                                        }
                                    })
                                }
                            }
                        }
                        .padding(5)
                    }
                }
                .ignoresSafeArea(.all)
            }
        }
    }
}
