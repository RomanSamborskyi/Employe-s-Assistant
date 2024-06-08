//
//  Extentions.swift
//  Employee's Assistant
//
//  Created by Roman Samborskyi on 03.02.2024.
//

import SwiftUI


extension Date {
    ///Create an array of date from current month
    func datesOfMonth() -> [Date] {
        let calendar = Calendar.current
        let currentMonth = calendar.component(.month, from: self)
        let currentYear = calendar.component(.year, from: self)
        var startDateComponents = DateComponents()
        startDateComponents.year = currentYear
        startDateComponents.month = currentMonth
        startDateComponents.day = 1
        let startDate = calendar.date(from: startDateComponents)!
        
        var endDateComponents = DateComponents()
        endDateComponents.month = 1
        endDateComponents.day = -1
        let endDate = calendar.date(byAdding: endDateComponents, to: startDate)!
        var dates: [Date] = []
                    var currentDate = startDate
                    while currentDate <= endDate {
            dates.append (currentDate)
                        currentDate = calendar.date(byAdding: .day, value: 1, to: currentDate)!
        }
         return dates
    }
}

extension Color {
    ///Setting new accent color to use across the app
    static var newAccentColor: Color {
        guard let components = UserDefaults.standard.value(forKey: "color") as? [CGFloat] else { return Color.accentColor }
        return Color(.sRGB, red: components[0], green: components[1], blue: components[2], opacity: components[3] )
    }
}

extension Binding where Value == Bool{
    init<T>(value: Binding<T?>) {
        self.init {
            return value.wrappedValue != nil
        } set: { newValue in
            if !newValue {
                value.wrappedValue = nil
            }
        }
    }
}

extension UIColor {
    var rgb: (red: CGFloat, green: CGFloat, blue: CGFloat)? {
        var red: CGFloat = 0
        var green: CGFloat = 0
        var blue: CGFloat = 0
        var alpha: CGFloat = 0
        
        guard self.getRed(&red, green: &green, blue: &blue, alpha: &alpha) else {
            return nil
        }
        
        return (red, green, blue)
    }
}

extension Color {
    var uiColor: UIColor {
        let component = UIColor(self).cgColor.components!
        
        return UIColor(red: component[0], green: component[1], blue: component[2], alpha: component[3])
    }
}

extension Color {
    func darker(per percentage: Double) -> Color {
        guard let rgb = self.uiColor.rgb else { return self }
        
        return Color(
            red: max(rgb.red - percentage / 100, 0),
            green: max(rgb.green - percentage / 100, 0),
            blue: max(rgb.blue - percentage / 100, 0))
    }
}
