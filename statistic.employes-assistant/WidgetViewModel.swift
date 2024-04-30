//
//  WidgetViewModel.swift
//  statistic.employes-assistantExtension
//
//  Created by Roman Samborskyi on 09.03.2024.
//

import Foundation
import SwiftUI
import CoreData

class WidgetViewModel: ObservableObject {
    static let instanse: WidgetViewModel = WidgetViewModel()
    

    func getSavedColor() -> Color? {
        var newColor: Color? = nil
        do {
            let contianer = CoreDataManager.instanse.container.viewContext
            let request = NewColorEntity.fetchRequest()
            let result = try contianer.fetch(request)
            
            for item in result {
                newColor = Color(.sRGB, red: CGFloat(item.red), green: CGFloat(item.green), blue: CGFloat(item.blue), opacity: CGFloat(item.opacity) )
            }
        } catch {
            print("Error of fetching color: \(error)")
        }
        return newColor
    }
    
    func checkDays(_ day: CalendarDates?, _ month: MonthEntity) -> Bool {
        guard let array = month.day?.allObjects as? [DayEntity] else { return false }
        var tempBool: Bool = false
        let dateFormatter: DateFormatter = {
            let dateFormatter = DateFormatter()
            dateFormatter.dateStyle = .short
            return dateFormatter
        }()
        
        let dayDate = dateFormatter.string(from: day!.date)
        
        guard let firsDay = array.firstIndex(where: { dateFormatter.string(from: $0.date!) == dayDate }) else { return false }
        let element = array[firsDay]
        let elementDate = dateFormatter.string(from: element.date!)
        if dayDate == elementDate {
            tempBool = true
        }
        return tempBool
    }
    
    func fetchDates(_ month: MonthEntity) -> [CalendarDates] {
        let current = Calendar.current
        
        let currentMonth = getCurrentMont(month)
        
        var monthDays = currentMonth.datesOfMonth().map {
            CalendarDates(day: current.component(.day, from: $0), date: $0)
        }
        
        let firstDayOfTheWeek = current.component(.weekday, from: monthDays.first?.date ?? Date())
        if firstDayOfTheWeek > 1 {
            for _ in 0..<firstDayOfTheWeek - 2 {
                monthDays.insert(CalendarDates(day: -1, date: Date()), at: 0)
            }
        } else if firstDayOfTheWeek <= 1 {
            for _ in -7..<firstDayOfTheWeek - 2 {
                monthDays.insert(CalendarDates(day: -1, date: Date()), at: 0)
            }
        }
        
        return monthDays
    }
    
    func getCurrentMont(_ selectedMonth: MonthEntity) -> Date {
        let calendar = Calendar.current

        let dateFormatter: DateFormatter = {
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "LLLL yyyy"
            return dateFormatter
        }()
        
        guard let title = selectedMonth.title else { return Date() }
        let indexOfSpace = title.firstIndex(of: " ") ?? title.endIndex
        let clearTitle = title[..<indexOfSpace]
        let yaer = title[indexOfSpace...]
        let localizedString = NSLocalizedString(String(clearTitle), comment: "") + String(yaer)

        guard let currentMonth = dateFormatter.date(from: localizedString) else { return Date() }
            let returnedMonth = calendar.date(bySetting: .day, value: 1, of: currentMonth)
            if let formattedMonth = returnedMonth {
                return formattedMonth
            }
        
        return Date()
    }
    
    func fetchDays(from month: MonthEntity) -> [DayEntity] {
        let request = NSFetchRequest<DayEntity>(entityName: CoreDataManager.instanse.dayEntity)
        request.sortDescriptors = [NSSortDescriptor(keyPath: \DayEntity.date, ascending: false)]
        request.predicate = NSPredicate(format: "month == %@", month)
        do {
            return try CoreDataManager.instanse.context.fetch(request)
        } catch let error {
            print("Error of fetching days: \(error.localizedDescription)")
            return []
        }
    }
    
    func countHoursTitle(for month: MonthEntity) -> String {
        let daysArray = fetchDays(from: month)
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
    
    func getMonts() throws -> [MonthEntity] {
        let container = CoreDataManager.instanse.container.viewContext
        
        let request = MonthEntity.fetchRequest()
        let result = try container.fetch(request)
        return result
    }
    
    var dateFormater: DateFormatter = {
        var dateFormater: DateFormatter = DateFormatter()
        dateFormater.dateFormat = "LLLL yyyy"
        return dateFormater
    }()
    
    func localizedMonthTitle(title: String?) -> String {
        guard let title = title else { return "" }
        let indexOfSpace = title.firstIndex(of: " ") ?? title.endIndex
        let clearTitle = title[..<indexOfSpace]
        let yaer = title[indexOfSpace...]
        return NSLocalizedString(String(clearTitle), comment: "") + String(yaer)
    }
    
    func getCurrentMonth() -> MonthEntity? {
        guard let index = try? getMonts().firstIndex(where: { localizedMonthTitle(title: $0.title) == dateFormater.string(from: Date()).capitalized }) else { return nil }
        return try? getMonts()[index]
    }
    
    func trimCalculation(for month: MonthEntity) -> CGFloat {
        let hours = month.totalHours
        let scorePercent = CGFloat(hours) / CGFloat(month.monthTarget) * CGFloat(100)
        let currentTrim: CGFloat = CGFloat(scorePercent) / CGFloat(1.0) / CGFloat(100)
        return currentTrim
    }
}
