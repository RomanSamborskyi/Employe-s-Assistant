//
//  Employe_s_AssistantApp.swift
//  Employe's Assistant
//
//  Created by Roman Samborskyi on 01.12.2023.
//

import SwiftUI

@main
struct Employe_s_AssistantApp: App {
    
    @AppStorage("isDark") var isDark: Bool = false
    @Environment(\.colorScheme) var colorScheme
    
    var body: some Scene {
        WindowGroup {
            OnboardingMainView()
                .environment(\.colorScheme, isDark ? .dark : .light)
        }
    }
}



