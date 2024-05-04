//
//  OnboardingViewModel.swift
//  Employee's Assistant
//
//  Created by Roman Samborskyi on 26.03.2024.
//

import Foundation


class OnboardingViewModel: ObservableObject {
    
    
    let monthsViewModel: MonthsViewModel
    let settingsViewModel: SettingsViewModel
    
    init(monthsViewModel: MonthsViewModel, settingsViewModel: SettingsViewModel) {
        self.monthsViewModel = monthsViewModel
        self.settingsViewModel = settingsViewModel
    }
    
    
    func addNewMonth(title: String, monthTarget: Int32) {
        monthsViewModel.addNewMonth(title: title, monthTarget: monthTarget)
    }
    
    func setHourSalary(salary: Double) {
        settingsViewModel.saveHourSalary(salary)
    }
}
