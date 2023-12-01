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
    
    @Published var months: [MontEntity] = []
    
    init() { }
    
    func fetchMonths() {
        let request = NSFetchRequest<MontEntity>(entityName: coreData.monthsEntety)
        request.sortDescriptors = [NSSortDescriptor(keyPath: \MontEntity.date, ascending: true)]
        do {
            try months = coreData.context.fetch(request)
        } catch let error {
            print("Error of fetching months: \(error.localizedDescription)")
        }
    }
    
    func fetchDays(from month: MontEntity) -> [DayEntity] {
        let request = NSFetchRequest<DayEntity>(entityName: coreData.dayEntity)
        request.sortDescriptors = [NSSortDescriptor(keyPath: \DayEntity.date, ascending: false)]
        request.predicate = NSPredicate(format: "month == @%", month)
        
        do {
            return try coreData.context.fetch(request)
        } catch let error {
            print("Error of fetching days: \(error.localizedDescription)")
            return []
        }
    }
    
    func save() {
        coreData.save()
    }
}
