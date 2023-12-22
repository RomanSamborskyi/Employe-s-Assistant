//
//  MonthsViewModel.swift
//  Employe's Assistant
//
//  Created by Roman Samborskyi on 01.12.2023.
//

import Foundation
import CoreData


class MonthsViewModel: ObservableObject {
    
    let coreData: CoreDataManager = CoreDataManager.instanse
    static let instance: MonthsViewModel = MonthsViewModel()
    let settings: SettingsViewModel = SettingsViewModel.instance
    
    @Published var months: [MonthEntity] = []
    
    init() { 
        fetchMonths()
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
    
    func countHours(for month: MonthEntity) -> Double {
        let daysArray = fetchDays(from: month)
        var hoursArray: [Double] = []
        for day in daysArray {
            let minutes = Double(day.hours * 60 ) + Double(day.minutes)
            hoursArray.append(minutes)
        }
        return hoursArray.reduce(0,+) / 60
    }
    
    func countSalary(for month: MonthEntity) -> Double {
        let totalHours = countHours(for: month)
        return totalHours * settings.returnHourSalary()
    }
    
    func progressBar(for month: MonthEntity) -> CGFloat {
        let target = month.monthTarget
        let curentHours = countHours(for: month)
        let percent = curentHours / Double(target) * 100
        if percent >= 100 {
            return CGFloat(100)
        } else if month.monthTarget == 0 {
            return 0
        } else {
            return CGFloat(percent)
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
        month.totalHours = countHours(for: month)
        month.totalSalary = countSalary(for: month)
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
