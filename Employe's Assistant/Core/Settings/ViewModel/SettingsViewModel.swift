//
//  SettingsViewModel.swift
//  Employe's Assistant
//
//  Created by Roman Samborskyi on 22.12.2023.
//

import Foundation


class SettingsViewModel: ObservableObject {
    
    static let instance: SettingsViewModel = SettingsViewModel()
    
    @Published var hourSalary: Double = 160

}

