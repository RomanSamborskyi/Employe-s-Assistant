//
//  DataManager.swift
//  Employee's Assistant
//
//  Created by Roman Samborskyi on 26.02.2024.
//

import Foundation
import CoreData

class DataManager {
    static let instanse: DataManager = DataManager()
    let coreData: CoreDataManager = CoreDataManager.instanse
    
    
    
    func getMonths() -> [Month]? {
        var months: [Month] = []
        
        for month in fetchMonths() {
            var dayArray: [Day]? = []
            guard let days = month.day?.allObjects as? [DayEntity] else { return nil }
            for day in days {
              let convday = Day(date: day.date ?? Date(), endHours: day.endHours, endMinutes: day.endMinutes, hours: day.hours, minutes: day.minutes, pauseTime: day.pauseTime, startHours: day.startHours, startMinutes: day.startMinutes)
                dayArray?.append(convday)
            }
            let convertedMonth = Month(date: month.date ?? Date(), monthTarget: month.monthTarget , title: month.title ?? "", totalHours: month.totalHours, totalSalary: month.totalSalary, trim: month.trim, days: dayArray)
            months.append(convertedMonth)
        }
        return months
    }
    
    func fetchMonths() -> [MonthEntity] {
        let request = NSFetchRequest<MonthEntity>(entityName: coreData.monthsEntety)
        request.sortDescriptors = [NSSortDescriptor(keyPath: \MonthEntity.date, ascending: false)]
        do {
            return try coreData.context.fetch(request)
        } catch let error {
            print("Error of fetching months: \(error.localizedDescription)")
            return []
        }
    }
    
    func countHoursTitle(for month: MonthEntity, _ daysArray: [DayEntity]) -> String {
        var hoursArray: [Double] = []
        for day in daysArray {
            let minutes = Double(day.hours * 60 ) + Double(day.minutes)
            hoursArray.append(minutes)
        }
        let totalHours = String(hoursArray.reduce(0, +) / 60)
        let index = totalHours.firstIndex(of: ".") ?? totalHours.endIndex
        let hour = totalHours[..<index]
        var minute = totalHours[index...]
        minute.removeFirst()
        var convertInToMonute: Int = 0
        if minute.count <= 1 {
            convertInToMonute = (60 * (Int(minute) ?? 0) / 10)
        } else if minute.count >= 2 {
            convertInToMonute = (60 * (Int(minute) ?? 0) / 100)
        }
        return "\(hour):\(convertInToMonute)"
    }
}
