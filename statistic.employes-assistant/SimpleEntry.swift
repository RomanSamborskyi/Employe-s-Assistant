//
//  SimpleEntry.swift
//  statistic.employes-assistantExtension
//
//  Created by Roman Samborskyi on 09.03.2024.
//

import Foundation
import WidgetKit
import SwiftUI

struct SimpleEntry: TimelineEntry {
    let date: Date
    let configuration: ConfigurationAppIntent
    let month: MonthEntity
    let hoursTitle: String
    let color: Color
}
