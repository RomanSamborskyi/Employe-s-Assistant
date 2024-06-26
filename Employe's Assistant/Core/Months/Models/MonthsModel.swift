//
//  MonthsModel.swift
//  Employe's Assistant
//
//  Created by Roman Samborskyi on 06.01.2024.
//

import UIKit


struct Month: Identifiable, Sendable {
    
    var id = UUID().uuidString
    var date: Date?
    var monthTarget: Int32?
    var title: String?
    var totalHours: Double?
    var totalSalary :Double?
    var trim: Double?
    var days: [Day]?
}


extension Month: Equatable {
    static func ==(lhs: Month, rhs: Month) -> Bool {
        return lhs.title == rhs.title
    }
}
