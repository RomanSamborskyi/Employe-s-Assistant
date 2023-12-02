//
//  CoreDataManager.swift
//  Employe's Assistant
//
//  Created by Roman Samborskyi on 01.12.2023.
//

import Foundation
import CoreData

class CoreDataManager {
    
    static let instanse: CoreDataManager = CoreDataManager()
    
    let container: NSPersistentContainer
    let context: NSManagedObjectContext
    
    private let containerName: String = "Container"
    let monthsEntety: String = "MonthEntity"
    let dayEntity: String = "DayEntity"
    let profileEntety: String = "ProfileEntity"
    
    init() {
        container = NSPersistentContainer(name: containerName)
        container.loadPersistentStores { description, error in
            if error != nil {
                print("Error of load core data: \(error.debugDescription)")
            } else {
                print("SUCCESS of loading core data")
            }
        }
        context = container.viewContext
        container.viewContext.mergePolicy = NSMergePolicy.mergeByPropertyObjectTrump
    }
    
    func save() {
        do {
           try context.save()
        } catch let error {
            print("Error of saving entity: \(error.localizedDescription)")
        }
    }
}
