//
//  NewColorEntity+CoreDataProperties.swift
//  Employee's Assistant
//
//  Created by Roman Samborskyi on 09.03.2024.
//

import Foundation
import CoreData

extension NewColorEntity {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<NewColorEntity> {
        return NSFetchRequest<NewColorEntity>(entityName: "NewColorEntity")
    }

    @NSManaged public var newAccentColor: Float

}

extension NewColorEntity: Identifiable {

}
