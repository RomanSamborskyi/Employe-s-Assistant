//
//  SettingsViewModel.swift
//  Employe's Assistant
//
//  Created by Roman Samborskyi on 22.12.2023.
//

import Foundation
import SwiftUI
import CoreData


class SettingsViewModel: ObservableObject {
    
    static let instance: SettingsViewModel = SettingsViewModel()
    let coreData: CoreDataManager = CoreDataManager.instanse
    
    @Published var currentIndex: Int = 0
    @Published var newAccentColor: Color = .accentColor
    var icons: [String?] = [nil]
    private let key: String = "color"
    
    init() {
        getColor()
        getAlternativeAppIcon()
        
        if let currentIcon = UIApplication.shared.alternateIconName {
            self.currentIndex = icons.firstIndex(of: currentIcon) ?? 0
        }
    }
    
    func exportCoreData() {
        do {
            if let entity = MonthEntity.entity().name {
                let request = NSFetchRequest<MonthEntity>(entityName: entity)
                request.relationshipKeyPathsForPrefetching = ["day"]
                let results = try coreData.context.fetch(request)
               
                let jasonFile = try JSONEncoder().encode(results)
                if let jsonString = String(data: jasonFile, encoding: .utf8) {
                    print(jsonString)
                }
            }
        } catch {
            print(error.localizedDescription)
        }
    }
    
    func checkIcon(icon: String?) -> Bool  {
        var boolValue: Bool = false
        if UIApplication.shared.alternateIconName == nil && currentIndex == icons.firstIndex(of: icon) || icon == UIApplication.shared.alternateIconName {
            boolValue = true
        }
        return boolValue
    }
    
    func getAlternativeAppIcon() {
        if let icons = Bundle.main.object(forInfoDictionaryKey: "CFBundleIcons") as? [String: Any], let alternativeIcons = icons["CFBundleAlternateIcons"] as? [String: Any] {
            for (_,value) in alternativeIcons {
                guard let iconList = value as? Dictionary<String,Any> else { return }
                guard let iconsArray = iconList["CFBundleIconFiles"] as? [String] else { return }
                guard let icon = iconsArray.first else { return }
                self.icons.append(icon)
            }
        }
    }
    
    func getColor() {
        guard let components = UserDefaults.standard.value(forKey: key) as? [CGFloat] else { return }
        let color = Color(.sRGB, red: components[0], green: components[1], blue: components[2], opacity: components[3] )
        DispatchQueue.main.async {
            self.newAccentColor = color
        }
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

