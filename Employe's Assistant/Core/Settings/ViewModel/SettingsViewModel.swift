//
//  SettingsViewModel.swift
//  Employe's Assistant
//
//  Created by Roman Samborskyi on 22.12.2023.
//

import Foundation


class SettingsViewModel: ObservableObject {
    
    static let instance: SettingsViewModel = SettingsViewModel()

    
    func saveHourSalary(_ newValue: Double) {
        UserDefaults.standard.setValue(newValue, forKey: "hourSalary")
    }
    func returnHourSalary() -> Double {
        return UserDefaults.standard.double(forKey: "hourSalary")
    }
}

