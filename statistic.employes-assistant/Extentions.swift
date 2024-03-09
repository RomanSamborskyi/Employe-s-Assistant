//
//  Extentions.swift
//  statistic.employes-assistantExtension
//
//  Created by Roman Samborskyi on 09.03.2024.
//

import Foundation

extension Date {
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

extension ConfigurationAppIntent {
    
    static var widgetType: ConfigurationAppIntent {
        let intent = ConfigurationAppIntent()
        intent.type = WidgetType.calendar
        return intent
    }
}
