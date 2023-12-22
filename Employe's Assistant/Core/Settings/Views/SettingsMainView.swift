//
//  SettingsMainView.swift
//  Employe's Assistant
//
//  Created by Roman Samborskyi on 01.12.2023.
//

import SwiftUI

struct SettingsMainView: View {
    
    @StateObject var vm: SettingsViewModel = SettingsViewModel()
    @AppStorage("isDark") var isDark: Bool = false
    
    var body: some View {
        NavigationView {
            List {
                Section("Appearance") {
                    Toggle("Appearance", isOn: $isDark)
                }
            }.navigationTitle("Settings")
        }
    }
}

#Preview {
    SettingsMainView()
}
