//
//  MonthEntity+CoreDataClass.swift
//  Employee's Assistant
//
//  Created by Roman Samborskyi on 01.02.2024.
//
//

import Foundation
import CoreData

@objc(MonthEntity)
public class MonthEntity: NSManagedObject, Codable {

    required convenience public init(from decoder: Decoder) throws {
        guard let context = decoder.userInfo[.context] as? NSManagedObjectContext else { throw  EncodingError.NoEncodingData }
        
        self.init(context: context)
        
        let values = try decoder.container(keyedBy: CodingKeys.self)
        
        date = try values.decode(Date.self, forKey: .date)
        monthTarget = try values.decode(Int32.self, forKey: .monthTarget)
        title = try values.decode(String.self, forKey: .title)
        totalHours = try values.decode(Double.self, forKey: .totalHours)
        totalSalary = try values.decode(Double.self, forKey: .totalSalary)
        trim = try values.decode(Double.self, forKey: .trim)
        if let dayArray = try? values.decode([DayEntity].self, forKey: .day) {
              // Convert the array to an NSSet
              let daySet = NSSet(array: dayArray)
              addToDay(daySet)
          }
    }
    
    public func encode(to encoder: Encoder) throws {
        var values = encoder.container(keyedBy: CodingKeys.self)
        try values.encode(date, forKey: .date)
        try values.encode(monthTarget, forKey: .monthTarget)
        try values.encode(title, forKey: .title)
        try values.encode(totalHours, forKey: .totalHours)
        try values.encode(totalSalary, forKey: .totalSalary)
        try values.encode(trim, forKey: .trim)
        if let daySet = day as? Set<DayEntity> {
              let dayArray = Array(daySet)
              try values.encode(dayArray, forKey: .day)
          }
    }
    
    enum CodingKeys: CodingKey {
        case date, monthTarget, title, totalHours, totalSalary, trim, day
    }
}

extension CodingUserInfoKey {
    static let context = CodingUserInfoKey(rawValue: "managedObjectContext")!
}


enum EncodingError: Error {
    case NoEncodingData
}
