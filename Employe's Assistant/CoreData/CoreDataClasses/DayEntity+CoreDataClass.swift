//
//  DayEntity+CoreDataClass.swift
//  Employee's Assistant
//
//  Created by Roman Samborskyi on 01.02.2024.
//
//

import Foundation
import CoreData

@objc(DayEntity)
public class DayEntity: NSManagedObject, Codable {

    required convenience public init(from decoder: Decoder) throws {
        guard let context = decoder.userInfo[.context] as? NSManagedObjectContext else { throw  EncodingError.NoEncodingData }
        
        self.init(context: context)
        
        let values = try decoder.container(keyedBy: CodingKeysDays.self)
        
        date = try values.decode(Date.self, forKey: .date)
        endHours = try values.decode(Int32.self, forKey: .endHours)
        endMinutes = try values.decode(Int32.self, forKey: .endMinutes)
        hours = try values.decode(Int32.self, forKey: .hours)
        minutes = try values.decode(Int32.self, forKey: .minutes)
        pauseTime = try values.decode(Int32.self, forKey: .pauseTime)
        startHours = try values.decode(Int32.self, forKey: .startHours)
        startMinutes = try values.decode(Int32.self, forKey: .startMinutes)
    }
    
    public func encode(to encoder: Encoder) throws {
        var values = encoder.container(keyedBy: CodingKeysDays.self)
        try values.encode(date, forKey: .date)
        try values.encode(endHours, forKey: .endHours)
        try values.encode(endMinutes, forKey: .endMinutes)
        try values.encode(hours, forKey: .hours)
        try values.encode(minutes, forKey: .minutes)
        try values.encode(pauseTime, forKey: .pauseTime)
        try values.encode(startHours, forKey: .startHours)
        try values.encode(startMinutes, forKey: .startMinutes)
    }
    
    enum CodingKeysDays: CodingKey {
        case date, endHours, endMinutes, hours, minutes, pauseTime,startHours, startMinutes
    }
}

