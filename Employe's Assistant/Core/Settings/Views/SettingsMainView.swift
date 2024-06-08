//
//  SettingsMainView.swift
//  Employe's Assistant
//
//  Created by Roman Samborskyi on 01.12.2023.
//

import SwiftUI

struct SettingsMainView: View {
    
    @StateObject var vm: SettingsViewModel
    @Binding var hideTabBar: Bool
    @AppStorage("isDark") var isDark: Bool = false
    @State private var setHours: Bool = false
    @State private var hourSalary: Double = 0
    
    init(dataManager: DataManager, hideTabBar: Binding<Bool>) {
        _vm = StateObject(wrappedValue: SettingsViewModel(dataManager: dataManager))
        _hideTabBar = hideTabBar
    }
    
    var body: some View {
        NavigationView {
            List {
                Section("Appearance") {
                    HStack {
                        Image(systemName: isDark ? "moon.fill" : "sun.min.fill")
                        Toggle(isDark ? "Dark" : "Light", isOn: $isDark)
                    }
                }
                Section("Hour salary") {
                    HStack {
                        Image(systemName: "banknote")
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
                        NavigationLink(destination: {
                            BackUpMainView(vm: vm)
                                .onAppear {
                                    withAnimation(Animation.smooth) {
                                        self.hideTabBar = true
                                    }
                                }
                                .onDisappear {
                                    withAnimation(Animation.smooth) {
                                        self.hideTabBar = false
                                    }
                                }
                        }) {
                            Image(systemName: "icloud.fill")
                            Text("BackUp")
                        }
                    }
                    HStack {
                        NavigationLink(destination: {
                            AlternativeIconView(vm: vm)
                                .onAppear {
                                    withAnimation(Animation.smooth) {
                                        self.hideTabBar = true
                                    }
                                }
                                .onDisappear {
                                    withAnimation(Animation.smooth) {
                                        self.hideTabBar = false
                                    }
                                }
                        }) {
                            Image(systemName: "photo.on.rectangle.angled")
                            Text("App icon")
                        }
                    }
                    HStack {
                        NavigationLink(destination: {
                            ColorPickerView(vm: vm)
                                .onAppear {
                                    withAnimation(Animation.smooth) {
                                        self.hideTabBar = true
                                    }
                                }
                                .onDisappear {
                                    withAnimation(Animation.smooth) {
                                        self.hideTabBar = false
                                    }
                                }
                        }, label: {
                            Image(systemName: "paintpalette.fill")
                            Text("Accent color")
                        })
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

