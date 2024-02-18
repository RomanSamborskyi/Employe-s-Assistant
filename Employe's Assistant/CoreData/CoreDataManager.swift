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
    let appgroupID: String = "group.hoursApp.Hours.StatisticWidget"
    
    init() {
        container = NSPersistentContainer(name: containerName)
        container.viewContext.mergePolicy = NSMergePolicy.mergeByPropertyObjectTrump
        let url = URL.storeURL(for: appgroupID, dataBase: containerName)
        let storeDescription = NSPersistentStoreDescription(url: url)
        container.persistentStoreDescriptions = [storeDescription]
        container.loadPersistentStores { description, error in
            if error != nil {
                print("Error of load core data: \(error.debugDescription)")
            } else {
                print("SUCCESS of loading core data")
            }
        }
        context = container.viewContext
    }
    
    func save() {
        do {
           try context.save()
        } catch let error {
            print("Error of saving entity: \(error.localizedDescription)")
        }
    }
}

public extension URL {
    static func storeURL(for appgroup: String, dataBase: String) -> URL {
        guard let container = FileManager.default.containerURL(forSecurityApplicationGroupIdentifier: appgroup) else {
            print("Error of creating of url for appgroup")
            fatalError()
        }
        return container.appendingPathComponent("\(dataBase).sqlite")
    }
}
