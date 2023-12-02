//
//  MonthsViewModel.swift
//  Employe's Assistant
//
//  Created by Roman Samborskyi on 01.12.2023.
//

import Foundation
import CoreData



final class MonthsViewModel: ObservableObject {
    
    let coreData: CoreDataManager = CoreDataManager.instanse
    
    @Published var months: [MonthEntity] = []
    @Published var days: [MonthEntity:[DayEntity]] = [:]
    
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
    
    func addNewMonth(title: String, monthTarget: Int32) {
        let newMonth = MonthEntity(context: coreData.context)
        newMonth.title = title
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
        let convertInToMinutes = 60 * (Int(minute) ?? 30 / 10000)
        newDay.month = month
        newDay.date = date
        newDay.hours = Int32(hour) ?? 0
        newDay.minutes = Int32(convertInToMinutes)
        newDay.startHours = startHours
        newDay.startMinutes = startMinutes
        newDay.endHours = endHours
        newDay.endMinutes = endMinutes
        newDay.pauseTime = pauseTime
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
