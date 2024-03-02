//
//  DaysModel.swift
//  Employe's Assistant
//
//  Created by Roman Samborskyi on 06.01.2024.
//

import UIKit


struct Days: Identifiable {
    var id = UUID().uuidString
    var date: Date
    var endHours: Int32
    var endMinutes: Int32
    var hours: Int32
    var minutes: Int32
    var pauseTime: Int32
    var startHours: Int32
    var startMinutes: Int32
}
