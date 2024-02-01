//
//  DayEntity+CoreDataProperties.swift
//  Employee's Assistant
//
//  Created by Roman Samborskyi on 01.02.2024.
//
//

import Foundation
import CoreData


extension DayEntity {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<DayEntity> {
        return NSFetchRequest<DayEntity>(entityName: "DayEntity")
    }

    @NSManaged public var date: Date?
    @NSManaged public var endHours: Int32
    @NSManaged public var endMinutes: Int32
    @NSManaged public var hours: Int32
    @NSManaged public var minutes: Int32
    @NSManaged public var pauseTime: Int32
    @NSManaged public var startHours: Int32
    @NSManaged public var startMinutes: Int32
    @NSManaged public var month: MonthEntity?

}

extension DayEntity : Identifiable {

}
