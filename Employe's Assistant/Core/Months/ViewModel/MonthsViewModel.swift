//
//  MonthsViewModel.swift
//  Employe's Assistant
//
//  Created by Roman Samborskyi on 01.12.2023.
//

import Foundation
import CoreData


final class MonthsViewModel: ObservableObject {
    
    private let coreData: CoreDataManager = CoreDataManager.instanse
    
    @Published var months: [MonthEntity] = []
    
    init() { 
        fetchMonths()
    }
    
    func fetchMonths() {
        let request = NSFetchRequest<MonthEntity>(entityName: coreData.monthsEntety)
        request.sortDescriptors = [NSSortDescriptor(keyPath: \MonthEntity.date, ascending: true)]
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
    
    func addHours(hours: Int32, minutes: Int32, startHours: Int32, startMinutes: Int32, endHours: Int32, endMinutes: Int32, pauseTime: Int32) {
        let newDay = DayEntity(context: coreData.context)
        newDay.date = Date()
        newDay.hours = hours
        newDay.minutes = minutes
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
