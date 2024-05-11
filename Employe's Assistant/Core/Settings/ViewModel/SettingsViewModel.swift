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
   ///Function to restore a data from hardcored json file, need becouse sendbox doesnt work on real device
//    func forseRestore() {
//        let file = "jsonFileExp"
//        
//        do {
//            if let path = Bundle.main.path(forResource: file, ofType: "json") {
//                if let jsonData = try String(contentsOfFile: path).data(using: .utf8) {
//                    let decoder = JSONDecoder()
//                    decoder.userInfo[.context] = coreData.context
//                    let result = try decoder.decode([MonthEntity].self, from: jsonData)
//                    print(result)
//                    
//                    try coreData.context.save()
//                }
//            }
//        } catch {
//            print("error of restoring: \(error.localizedDescription)")
//        }
//    }
    ///Import backup json file from device to app, decoded it and save to core data
    func importJSONFile(_ url: URL) {
        do {
            print(url)
           let jsonData = try Data(contentsOf: url)
            let decoder = JSONDecoder()
            decoder.userInfo[.context] = coreData.context
            _ = try decoder.decode([MonthEntity].self, from: jsonData)
            
            try coreData.context.save()
        } catch {
            print("Error of importing json: \(error.localizedDescription)")
        }
    }
    ///Delete temporary file after saving json file
    func delteTempFile(_ url: URL) {
        do {
            try FileManager.default.removeItem(at: url)
        } catch {
            print(error.localizedDescription)
        }
    }
    ///Export backup json file to "Files" app on device
    func exportCoreData() -> URL {
        
        var url: URL = URL(string: "google.com")!
        
        do {
            if let entity = MonthEntity.entity().name {
                let request = NSFetchRequest<MonthEntity>(entityName: entity)
                request.relationshipKeyPathsForPrefetching = ["day"]
                let results = try coreData.context.fetch(request)
               
                let jasonFile = try JSONEncoder().encode(results)
                if let jsonString = String(data: jasonFile, encoding: .utf8) {
                    if let tempURL = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first {
                        let pathURL = tempURL.appending(component: "Exposrt \(Date().formatted(date: .complete, time: .omitted)).json")
                        try jsonString.write(to: pathURL, atomically: true, encoding: .utf8)
                        url = pathURL
                    }
                }
            }
        } catch {
            print(error.localizedDescription)
        }
        return url
    }
    ///Check what icon currently setted
    func checkIcon(icon: String?) -> Bool  {
        var boolValue: Bool = false
        if UIApplication.shared.alternateIconName == nil && currentIndex == icons.firstIndex(of: icon) || icon == UIApplication.shared.alternateIconName {
            boolValue = true
        }
        return boolValue
    }
    ///Get list of alternative icons names
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
    ///Get collor from USerDefaults and set it in to local publisher
    func getColor() {
        guard let components = UserDefaults.standard.value(forKey: key) as? [CGFloat] else { return }
        let color = Color(.sRGB, red: components[0], green: components[1], blue: components[2], opacity: components[3] )
        DispatchQueue.main.async {
            self.newAccentColor = color
        }
    }
    ///Save hour salary in to UserDefaults
    func saveHourSalary(_ newValue: Double) {
        UserDefaults.standard.setValue(newValue, forKey: "hourSalary")
    }
    ///Function return hour salary from UserDefaults
    func returnHourSalary() -> Double {
        return UserDefaults.standard.double(forKey: "hourSalary")
    }
    ///Add new accent color to UserDefaults and Core data
    func addToUserDefaults() {
        let savedColor = UIColor(newAccentColor).cgColor
        if let component = savedColor.components {
            UserDefaults.standard.set(component, forKey: key)
            let color = NewColorEntity(context: coreData.context)
            color.red = Float(component[0])
            color.green = Float(component[1])
            color.blue = Float(component[2])
            color.opacity = Float(component[3])
            coreData.save()
        }
    }
    ///Function to reset accent color in to default value(Color.accentColor)
    func resetAccenrColor() {
        let color = UIColor(Color.accentColor).cgColor
        
        if let component = color.components {
            UserDefaults.standard.set(component, forKey: key)
            let color = NewColorEntity(context: coreData.context)
            color.red = Float(component[0])
            color.green = Float(component[1])
            color.blue = Float(component[2])
            color.opacity = Float(component[3])
            coreData.save()
        }
    }
}

