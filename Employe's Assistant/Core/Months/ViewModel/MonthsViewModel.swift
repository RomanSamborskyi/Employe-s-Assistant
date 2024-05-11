//
//  MonthsViewModel.swift
//  Employe's Assistant
//
//  Created by Roman Samborskyi on 01.12.2023.
//

import UIKit
import SwiftUI

class MonthsViewModel: ObservableObject {
    
  
    let dataManager: DataManager = DataManager.instanse
    @Published var months: [Month] = []
    @Published var currentDay: Day? = nil
    @Published var startFetchingData: Bool = false
    private let key: String = "color"
    
    init() {
        getMonths()
    }

    
    ///Fetching moths form database in to local publisher
    func getMonths() {
        self.startFetchingData = true
        Task {
            if let array = await dataManager.getMonths() {
                await MainActor.run {
                    withAnimation(Animation.bouncy) {
                        self.months = array
                        self.startFetchingData = false
                    }
                }
            }
        }
    }
    ///Check if specific month contain a specific day
    func ifContainDay(in month: Month, date: Date) -> Bool {
        guard let monthArray = months.first(where: { $0.title == month.title }),
              let days = monthArray.days else { return false }
        
        let dateFormatter: DateFormatter = {
            let dateFormatter = DateFormatter()
            dateFormatter.dateStyle = .short
            return dateFormatter
        }()
        
        return days.contains(where: { dateFormatter.string(from: $0.date ?? Date()) == dateFormatter.string(from: date) })
    }
    ///Check if database containe specific month
    func ifContain(month: String) -> Bool {
        let dateFormater: DateFormatter = {
            let dateFormater: DateFormatter = DateFormatter()
            dateFormater.dateStyle = .full
            dateFormater.dateFormat = " YYYY"
            return dateFormater
        }()
        let comparableMonth = month + dateFormater.string(from: Date())
        return months.contains(where: { localizedMonthTitle(title: $0.title) == comparableMonth })
    }
    ///Get current day for tap gestrue in Calendar view, for display details or delete selected day
    func getCurrentDay(_ day: CalendarDates?, _ month: Month) {
        let array = months.first(where: { $0.title == month.title })?.days
       
        let dateFormatter: DateFormatter = {
            let dateFormatter = DateFormatter()
            dateFormatter.dateStyle = .short
            return dateFormatter
        }()
      
        let dayDate = dateFormatter.string(from: day!.date)
        
        guard let firsDay = array?.firstIndex(where: { dateFormatter.string(from: $0.date ?? Date()) == dayDate }) else { return }
        self.currentDay = array?[firsDay]
    }
    ///Check if database contain day from calendar
    func checkDays(_ day: CalendarDates?, _ month: Month) -> Bool {
        let array = months.first(where: { $0.title == month.title })?.days
        var tempBool: Bool = false
        let dateFormatter: DateFormatter = {
            let dateFormatter = DateFormatter()
            dateFormatter.dateStyle = .short
            return dateFormatter
        }()
      
        let dayDate = dateFormatter.string(from: day!.date)
        
        guard let firsDay = array?.firstIndex(where: { dateFormatter.string(from: $0.date ?? Date()) == dayDate }) else { return false }
        let element = array?[firsDay]
        let elementDate = dateFormatter.string(from: element?.date ?? Date())
        if dayDate == elementDate {
            tempBool = true
        }
        return tempBool
    }
    ///Fetch dates from calendar to custom type CalendarDates
    func fetchDates(_ month: Month) -> [CalendarDates] {
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
    ///Get cuurent month from months in database whch match to current calendar month
    func getCurrentMont(_ selectedMonth: Month) -> Date {
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
    ///Function which return localizable title of a month from database
    func localizedMonthTitle(title: String?) -> String {
        guard let title = title else { return "no title" }
        let indexOfSpace = title.firstIndex(of: " ") ?? title.endIndex
        let clearTitle = title[..<indexOfSpace]
        let yaer = title[indexOfSpace...]
        return NSLocalizedString(String(clearTitle), comment: "") + String(yaer)
    }
    ///Count of ohirs for specific month
    func countHours(for month: Month) -> Double? {
        guard let daysArray = months.first(where: { $0.title == month.title })?.days else { return nil }
        var hoursArray: [Double] = []
        for day in daysArray {
            let minutes = Double((day.hours ?? 0) * 60 ) + Double(day.minutes ?? 0)
            hoursArray.append(minutes)
        }
        return hoursArray.reduce(0,+) / 60
    }
    ///Count a salary for specific month
    func countSalary(for month: Month) -> Double? {
        guard let totalHours = countHours(for: month) else { return nil }
        return totalHours * UserDefaults.standard.double(forKey: "hourSalary")
    }
    ///Calculation of prgress bar length
    func progressBar(for month: Month, width: CGFloat) -> CGFloat {
        let target = month.monthTarget ?? 0
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
    ///Counting a hours for specific month.Function return a string value of total hours in hour format
    func countHoursTitle(for month: Month) -> String? {
        guard let daysArray = months.first(where: { $0.title == month.title })?.days else { return nil }
        var hoursArray: [Double] = []
        for day in daysArray {
            let minutes = Double((day.hours ?? 0) * 60 ) + Double(day.minutes ?? 0)
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
    ///Add a new month.Function also contain method to add a new month to database
    func addNewMonth(title: String, monthTarget: Int32) {
        let dateFormater: DateFormatter = {
            let dateFormater: DateFormatter = DateFormatter()
            dateFormater.dateStyle = .full
            dateFormater.dateFormat = " YYYY"
            return dateFormater
        }()
        
        var newMonth = Month()
        newMonth.title = title + dateFormater.string(for: Date())!
        newMonth.monthTarget = monthTarget
        newMonth.date = Date()
        self.months.append(newMonth)
        dataManager.addToCoreDataMonth(month: newMonth)
        getMonths()
    }
    ///Add a new day.Function also contain method to add a new day to database
    func addHours(month: Month, startHours: Int32, startMinutes: Int32, endHours: Int32, endMinutes: Int32, pauseTime: Int32, date: Date) {
        guard var currentMonth = months.first(where: { $0.title == month.title }) else { return }
        var newDay = Day()
        
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
        currentMonth.days?.append(newDay)
        currentMonth.totalHours = countHours(for: currentMonth) ?? 0
        currentMonth.totalSalary = countSalary(for: currentMonth) ?? 0
        dataManager.addHoursToCoreData(month: currentMonth, day: newDay, hour: String(hour), minutes: minuteToString, convertInToMinutes: convertInToMinutes)
        getMonths()
    }
    ///Deleting a day from database,
    func deleteDay(month: Month, day: Day) {
            guard let index = months.first(where: { $0.title == month.title })?.days?.firstIndex(of: day),
                  var  daysArray = months.first(where: { $0.title == month.title })?.days
            else { return }
            dataManager.delete(day: day, month: month)
            daysArray.remove(at: index)
            getMonths()
    }
    ///Deleting a month from database
    func deleteMonth(indexSet: IndexSet) {
        guard let index = indexSet.first else { return }
        let month = months[index]
        months.remove(at: index)
        dataManager.delete(month: month)
        getMonths()
    }
}
