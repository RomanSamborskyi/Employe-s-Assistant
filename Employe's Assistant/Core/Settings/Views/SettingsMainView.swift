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
    @State private var setHours: Bool = false
    @State private var hourSalary: Double = 0
    var body: some View {
        NavigationView {
            List {
                Section("Appearance") {
                    HStack {
                        Image(systemName: "moon.fill")
                        Toggle("Appearance", isOn: $isDark)
                    }
                }
                Section("Hour salary") {
                    HStack {
                        Image(systemName: "dollarsign")
                        Text(String(format: "%.2f", hourSalary))
                        Spacer()
                        Button("Edit", action: {
                            withAnimation(Animation.bouncy) {
                                self.setHours.toggle()
                            }
                        })
                    }
                }
                Section("General") {
                    HStack {
                        Image(systemName: "icloud.fill")
                        Text("iCloud sync")
                    }
                    HStack {
                        Image(systemName: "photo.on.rectangle.angled")
                        Text("App icon")
                    }
                    HStack {
                        Image(systemName: "paintpalette.fill")
                        Text("Accent color")
                    }
                }
            }.navigationTitle("Settings")
                .sheet(isPresented: $setHours, content: {
                    SetHourSalaryView(vm: vm, setHours: $setHours, hourSalary: $hourSalary)
                })
                .onAppear {
                    self.hourSalary = vm.returnHourSalary()
                }
        }
    }
}

#Preview {
    SettingsMainView()
}


