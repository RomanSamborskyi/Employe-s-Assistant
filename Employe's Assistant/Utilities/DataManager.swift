//
//  DataManager.swift
//  Employee's Assistant
//
//  Created by Roman Samborskyi on 26.02.2024.
//

import Foundation
import CoreData


actor DataManager {
    
    let coreData: CoreDataManager = CoreDataManager.instanse
    
    init() {  }
    
    ///Get months from core data and converting them in to type Month
    func getMonths() async throws -> [Month]? {
        
        var months: [Month] = []
        
        do {
            for month in try fetchMonths() {
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
        } catch {
            throw AppError.noDataFromCoreData
        }
    }
    ///Fetching months from core data
    nonisolated func fetchMonths() throws -> [MonthEntity] {
        let request = NSFetchRequest<MonthEntity>(entityName: coreData.monthsEntety)
        request.sortDescriptors = [NSSortDescriptor(keyPath: \MonthEntity.date, ascending: false)]
        do {
            return try coreData.context.fetch(request)
        } catch {
            throw AppError.noDataFromCoreData
        }
    }
    ///Add the new month to core data
    nonisolated func addToCoreDataMonth(month: Month) {
        let coreDataMonth = MonthEntity(context: coreData.context)
        coreDataMonth.title = month.title ?? ""
        coreDataMonth.monthTarget = month.monthTarget ?? 0
        coreDataMonth.date = month.date ?? Date()
        save()
    }
    ///Add the new day in to core data
    nonisolated func addHoursToCoreData(month: Month, day: Day, hour: String, minutes: String, convertInToMinutes: Int) {
        let coreDataDay = DayEntity(context: coreData.context)
        guard let coreDataMonth = try? fetchMonths().first(where: { $0.title ?? "" == month.title}) else { return }
        
        if minutes.count == 3 {
            coreDataDay.minutes = Int32(convertInToMinutes / 10)
        } else if minutes.count > 3 {
            coreDataDay.minutes = Int32(convertInToMinutes / 100)
        }
        coreDataDay.month = coreDataMonth
        coreDataDay.date = day.date
        coreDataDay.hours = Int32(hour) ?? 0
        coreDataDay.startHours = day.startHours ?? 0
        coreDataDay.startMinutes = day.startMinutes ?? 0
        coreDataDay.endHours = day.endHours ?? 0
        coreDataDay.endMinutes = day.endMinutes ?? 0
        coreDataDay.pauseTime = day.pauseTime ?? 0
        var coreDataDaysarray = coreDataMonth.day?.allObjects as? [DayEntity]
        coreDataDaysarray?.append(coreDataDay)
        save()
    }
    ///Update total salary of specific month after added a new day in to core data
   nonisolated func updateTotalSalaryAndHours(month: Month, totalSalary: Double, totalHours: Double) {
        guard let coreDataMonth = try? fetchMonths().first(where: { $0.title == month.title }) else { return }
        coreDataMonth.totalHours = totalHours
        coreDataMonth.totalSalary = totalSalary
        save()
    }
    ///Delete specific day from core data
    nonisolated func delete(day: Day, month: Month) {
        guard let coreDataMonth = try? fetchMonths().first(where: { $0.title ?? "" == month.title}),
              let coreDataDaysarray = coreDataMonth.day?.allObjects as? [DayEntity],
              let coreDataItem = coreDataDaysarray.first(where: { $0.date == day.date })
        else { return }
        coreData.context.delete(coreDataItem)
        save()
    }
    ///Delete specific month from core data
    nonisolated  func delete(month: Month) {
        guard let month = try? fetchMonths().first(where: { $0.title ?? "" == month.title}) else { return }
        coreData.context.delete(month)
        save()
    }
    ///Save changes in core data
    nonisolated func save() {
        coreData.save()
    }
}
