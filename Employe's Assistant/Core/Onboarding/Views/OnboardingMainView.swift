//
//  OnboardingMainView.swift
//  Employee's Assistant
//
//  Created by Roman Samborskyi on 25.03.2024.
//

import SwiftUI



struct OnboardingMainView: View {
    
    @State var viewNumber: OnboardingPages = .first
    @State private var selectedMonth: Monthes = .empty
    @StateObject private var vm: OnboardingViewModel
    @State private var targetText: String = ""
    @State private var hourSalary: String = ""
    
    @Environment(\.dismiss) var dissmiss
    init(dataManager: DataManager) {
        _vm = StateObject(wrappedValue: OnboardingViewModel(monthsViewModel: MonthsViewModel(dataManager: dataManager), settingsViewModel: SettingsViewModel(dataManager: dataManager)))
    }
    
    var body: some View {
        VStack {
            switch viewNumber {
            case .first:
                FirstOnboardingView()
                    .transition(.move(edge: .trailing))
            case .second:
                SecondOnboardingView()
                    .transition(.move(edge: .trailing))
            case .thread:
                TheardOnboardingView()
                    .transition(.move(edge: .trailing))
            case .fourth:
                FourthOnboardingView(targetText: $targetText, hourSalary: $hourSalary, selectedMonth: $selectedMonth)
                    .transition(.move(edge: .trailing))
            }
            HStack {
                Button(action: {
                    switch viewNumber {
                    case .first:
                        withAnimation(Animation.bouncy) {
                            dissmiss.callAsFunction()
                            HapticEngineManager.instance.makeFeadback(with: .rigid)
                        }
                    case .second:
                        withAnimation(Animation.bouncy) {
                            dissmiss.callAsFunction()
                            HapticEngineManager.instance.makeFeadback(with: .rigid)
                        }
                    case .thread:
                        withAnimation(Animation.bouncy) {
                            dissmiss.callAsFunction()
                            HapticEngineManager.instance.makeFeadback(with: .rigid)
                        }
                    case .fourth:
                        withAnimation(Animation.bouncy) {
                            dissmiss.callAsFunction()
                            HapticEngineManager.instance.makeFeadback(with: .rigid)
                        }
                    }
                }, label: {
                    Text("Skip")
                        .fontWeight(.bold)
                        .foregroundStyle(Color.gray.opacity(0.5))
                })
                .padding()
                .foregroundStyle(Color.black)
                
                Spacer()
                
                ForEach(OnboardingPages.allCases, id: \.self) { page in
                    RoundedRectangle(cornerRadius: 15)
                        .frame(width: viewNumber == page ? 24 : 8, height: 8)
                        .onTapGesture {
                            withAnimation(Animation.bouncy) {
                                self.viewNumber = page
                            }
                        }
                }
                
                Spacer()
                
                Button(action: {
                    switch viewNumber {
                    case .first:
                        withAnimation(Animation.bouncy) {
                            self.viewNumber = .second
                            HapticEngineManager.instance.makeFeadback(with: .soft)
                        }
                    case .second:
                        withAnimation(Animation.bouncy) {
                            self.viewNumber = .thread
                            HapticEngineManager.instance.makeFeadback(with: .soft)
                        }
                    case .thread:
                        withAnimation(Animation.bouncy) {
                            self.viewNumber = .fourth
                            HapticEngineManager.instance.makeFeadback(with: .soft)
                        }
                    case .fourth:
                        withAnimation(Animation.bouncy) {
                            vm.addNewMonth(title: selectedMonth.description, monthTarget: Int32(targetText) ?? 0)
                            vm.setHourSalary(salary: Double(hourSalary) ?? 0)
                            HapticEngineManager.instance.hapticNotification(with: .success)
                            dissmiss.callAsFunction()
                        }
                    }
                }, label: {
                    Text(viewNumber == .fourth ? "Done" : "Next")
                        .fontWeight(.bold)
                })
                .padding()
            }.padding()
        }.foregroundStyle(Color.black)
            .background(Color.white)
    }
}

