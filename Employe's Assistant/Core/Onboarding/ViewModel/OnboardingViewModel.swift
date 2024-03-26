//
//  OnboardingViewModel.swift
//  Employee's Assistant
//
//  Created by Roman Samborskyi on 26.03.2024.
//

import Foundation


class OnboardingViewModel: ObservableObject {
    
    private let monthsViewModel: MonthsViewModel = MonthsViewModel.instance
    private let settingsViewModel: SettingsViewModel = SettingsViewModel.instance
    
    
    func addNewMonth(title: String, monthTarget: Int32) {
        monthsViewModel.addNewMonth(title: title, monthTarget: monthTarget)
    }
    
    func setHourSalary(salary: Double) {
        settingsViewModel.saveHourSalary(salary)
    }
}
