//
//  MonthsViewModel.swift
//  Employe's Assistant
//
//  Created by Roman Samborskyi on 01.12.2023.
//

import UIKit
import CoreData
import SwiftUI


class MonthsViewModel: ObservableObject {
    
    static let instance: MonthsViewModel = MonthsViewModel()
    let coreData: CoreDataManager = CoreDataManager.instanse

    @Published var months: [MonthEntity] = []
    @Published var currentDay: DayEntity? = nil
    @Published var newAccentColor: Color = .accentColor
    private let key: String = "color"
    
    init() {
        fetchMonths()
        getColor()
    }
    
    func getColor() {
        guard let components = UserDefaults.standard.value(forKey: key) as? [CGFloat] else { return }
        let color = Color(.sRGB, red: components[0], green: components[1], blue: components[2], opacity: components[3] )
        DispatchQueue.main.async {
            self.newAccentColor = color
        }
    }
    
    func getCurrentDay(_ day: CalendarDates?, _ month: MonthEntity) {
        guard let array = month.day?.allObjects as? [DayEntity] else { return }
       
        let dateFormatter: DateFormatter = {
            let dateFormatter = DateFormatter()
            dateFormatter.dateStyle = .short
            return dateFormatter
        }()
      
        let dayDate = dateFormatter.string(from: day!.date)
        
        guard let firsDay = array.firstIndex(where: { dateFormatter.string(from: $0.date!) == dayDate }) else { return }
        self.currentDay = array[firsDay]
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

        guard let currentMonth = dateFormatter.date(from: localizedMonthTitle(title: selectedMonth.title)) else { return Date() }
            let returnedMonth = calendar.date(bySetting: .day, value: 1, of: currentMonth)
            if let formattedMonth = returnedMonth {
                return formattedMonth
            }
        
        return Date()
    }
    
    func localizedMonthTitle(title: String?) -> String {
        guard let title = title else { return "no title" }
        let indexOfSpace = title.firstIndex(of: " ") ?? title.endIndex
        let clearTitle = title[..<indexOfSpace]
        let yaer = title[indexOfSpace...]
        return NSLocalizedString(String(clearTitle), comment: "") + String(yaer)
    }
    
    func fetchMonths() {
        let request = NSFetchRequest<MonthEntity>(entityName: coreData.monthsEntety)
        request.sortDescriptors = [NSSortDescriptor(keyPath: \MonthEntity.date, ascending: false)]
        do {
            try months = coreData.context.fetch(request)
        } catch let error {
            print("Error of fetching months: \(error.localizedDescription)")
        }
    }
    
    func fetchDays(from month: MonthEntity) -> [DayEntity] {
        let request = NSFetchRequest<DayEntity>(entityName: coreData.dayEntity)
        request.sortDescriptors = [NSSortDescriptor(keyPath: \DayEntity.date, ascending: false)]
        request.predicate = NSPredicate(format: "month == %@", month)
        do {
           return try coreData.context.fetch(request)
        } catch let error {
            print("Error of fetching days: \(error.localizedDescription)")
            return []
        }
    }
    
    func countHours(for month: MonthEntity) -> Double? {
        guard let daysArray = month.day?.allObjects as? [DayEntity] else { return nil }
        var hoursArray: [Double] = []
        for day in daysArray {
            let minutes = Double(day.hours * 60 ) + Double(day.minutes)
            hoursArray.append(minutes)
        }
        return hoursArray.reduce(0,+) / 60
    }
    
    func countSalary(for month: MonthEntity) -> Double? {
        guard let totalHours = countHours(for: month) else { return nil }
        return totalHours * UserDefaults.standard.double(forKey: "hourSalary")
    }
    
    func progressBar(for month: MonthEntity, width: CGFloat) -> CGFloat {
        let target = month.monthTarget
        let curentHours = countHours(for: month) ?? 0
        let percent = curentHours / Double(target) * width
        if percent >= width {
            return CGFloat(width)
        } else if month.monthTarget == 0 {
            return 0
        } else {
            return CGFloat(percent)
        }
     }
    
    func countHoursTitle(for month: MonthEntity) -> String? {
        guard let daysArray = month.day?.allObjects as? [DayEntity] else { return nil }
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
    
    func addNewMonth(title: String, monthTarget: Int32) {
        let dateFormater: DateFormatter = {
            let dateFormater: DateFormatter = DateFormatter()
            dateFormater.dateStyle = .full
            dateFormater.dateFormat = " YYYY"
            return dateFormater
        }()
        let newMonth = MonthEntity(context: coreData.context)
        newMonth.title = title + dateFormater.string(for: Date())!
        newMonth.monthTarget = monthTarget
        newMonth.date = Date()
        save()
    }
    
    func addHours(month: MonthEntity, startHours: Int32, startMinutes: Int32, endHours: Int32, endMinutes: Int32, pauseTime: Int32, date: Date) {
        let newDay = DayEntity(context: coreData.context)
        let convertToMinutes = ((Double(endHours) * 60 + Double(endMinutes)) - (Double(startHours) * 60 + Double(startMinutes)) - Double(pauseTime)) / 60
        let stringOfMinutes: String = String(convertToMinutes)
        let index = stringOfMinutes.firstIndex(of: ".") ?? stringOfMinutes.endIndex
        let hour = stringOfMinutes[..<index]
        var minute = stringOfMinutes[index...]
        minute.removeFirst()
        let convertInToMinutes = (60 * (Int(minute) ?? 30 / 100))
        let minuteToString = String(convertInToMinutes)
        if minuteToString.count == 3 {
            newDay.minutes = Int32(convertInToMinutes / 10)
        } else if minuteToString.count > 3 {
            newDay.minutes = Int32(convertInToMinutes / 100)
        }
        newDay.month = month
        newDay.date = date
        newDay.hours = Int32(hour) ?? 0
        newDay.startHours = startHours
        newDay.startMinutes = startMinutes
        newDay.endHours = endHours
        newDay.endMinutes = endMinutes
        newDay.pauseTime = pauseTime
        month.totalHours = countHours(for: month) ?? 0
        month.totalSalary = countSalary(for: month) ?? 0
        save()
    }
    
    func deleteDay(month: MonthEntity, day: DayEntity) {
        guard let daysArray = month.day?.allObjects as? [DayEntity] else { return }
        guard let index = daysArray.firstIndex(of: day) else { return }
        let item = daysArray[index] 
        coreData.context.delete(item)
        save()
    }
    
    func deleteMonth(indexSet: IndexSet) {
        guard let index = indexSet.first else { return }
        let item = months[index]
        coreData.context.delete(item)
        save()
    }
    
    func save() {
        coreData.save()
        fetchMonths()
    }
}
