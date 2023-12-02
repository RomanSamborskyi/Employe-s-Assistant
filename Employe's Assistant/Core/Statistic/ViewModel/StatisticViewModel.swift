//
//  StatisticViewModel.swift
//  Employe's Assistant
//
//  Created by Roman Samborskyi on 02.12.2023.
//

import Foundation
import CoreData

class StatisticViewModel: ObservableObject {
    
    let monthViewModel: MonthsViewModel = MonthsViewModel.instance
    @Published var currentMonth: MonthEntity? = nil
    
    init() { getCurrentMonth() }
    
    var dateFormater: DateFormatter = {
        var dateFormater: DateFormatter = DateFormatter()
        dateFormater.dateStyle = .full
        dateFormater.dateFormat = "MMMM YYYY"
        return dateFormater
    }()
    
    func getCurrentMonth() {
        guard let index = monthViewModel.months.firstIndex(where: { $0.title == dateFormater.string(from: Date()) }) else { return }
        let month = monthViewModel.months[index]
        currentMonth = month
    }
}
