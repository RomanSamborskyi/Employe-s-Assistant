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
    @Published var selectedIndex: Int = 0
    
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
        selectedIndex = index
        currentMonth = month
    }
    
    func trimCalculation(for month: MonthEntity){
        guard let index = monthViewModel.months.firstIndex(where: { $0.id == month.id }) else { return }
        let currentMonth = monthViewModel.months[index]
        let hours = monthViewModel.countHours(for: month)
        let scorePercent = CGFloat(hours) / CGFloat(currentMonth.monthTarget) * CGFloat(100)
        let currentTrim: CGFloat = CGFloat(scorePercent) / CGFloat(1.0) / CGFloat(100)
        month.trim = currentTrim
    }
}
