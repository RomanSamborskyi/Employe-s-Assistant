//
//  SettingsViewModel.swift
//  Employe's Assistant
//
//  Created by Roman Samborskyi on 22.12.2023.
//

import Foundation
import SwiftUI

class SettingsViewModel: ObservableObject {
    
    static let instance: SettingsViewModel = SettingsViewModel()
    @Published var newAccentColor: Color = .accentColor
    private let key: String = "color"
    
    init() {
        getColor()
    }
    
    func getColor() {
        guard let components = UserDefaults.standard.value(forKey: key) as? [CGFloat] else { return }
        let color = Color(.sRGB, red: components[0], green: components[1], blue: components[2], opacity: components[3] )
        self.newAccentColor = color
    }
    func saveHourSalary(_ newValue: Double) {
        UserDefaults.standard.setValue(newValue, forKey: "hourSalary")
    }
    func returnHourSalary() -> Double {
        return UserDefaults.standard.double(forKey: "hourSalary")
    }
    func addToUserDefaults() {
        let savedColor = UIColor(newAccentColor).cgColor
        
        if let component = savedColor.components {
            UserDefaults.standard.set(component, forKey: key)
        }
    }
    func resetAccenrColor() {
        let color = UIColor(Color.accentColor).cgColor
        
        if let component = color.components {
            UserDefaults.standard.set(component, forKey: key)
        }
    }
}

