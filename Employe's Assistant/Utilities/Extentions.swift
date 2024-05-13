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
