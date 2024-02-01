//
//  MonthEntity+CoreDataProperties.swift
//  Employee's Assistant
//
//  Created by Roman Samborskyi on 01.02.2024.
//
//

import Foundation
import CoreData


extension MonthEntity {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<MonthEntity> {
        return NSFetchRequest<MonthEntity>(entityName: "MonthEntity")
    }
    
    @NSManaged public var date: Date?
    @NSManaged public var monthTarget: Int32
    @NSManaged public var title: String?
    @NSManaged public var totalHours: Double
    @NSManaged public var totalSalary: Double
    @NSManaged public var trim: Double
    @NSManaged public var day: NSSet?

}

// MARK: Generated accessors for day
extension MonthEntity {

    @objc(addDayObject:)
    @NSManaged public func addToDay(_ value: DayEntity)

    @objc(removeDayObject:)
    @NSManaged public func removeFromDay(_ value: DayEntity)

    @objc(addDay:)
    @NSManaged public func addToDay(_ values: NSSet)

    @objc(removeDay:)
    @NSManaged public func removeFromDay(_ values: NSSet)

}

extension MonthEntity : Identifiable {

}
