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
    
    init() {
        getCurrentMonth()
        trimCalculation()
    }
    
    
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
    
    func trimCalculation() {
        guard let month = currentMonth else { return }
        let hours = monthViewModel.countHours(for: month) ?? 0
        let scorePercent = CGFloat(hours) / CGFloat(month.monthTarget) * CGFloat(100)
        let currentTrim: CGFloat = CGFloat(scorePercent) / CGFloat(1.0) / CGFloat(100)
        month.trim = currentTrim
        monthViewModel.save()
    }
    
    func calculateSegmentHeight(day: DayEntity) -> CGFloat? {
        guard let array = currentMonth?.day?.allObjects as? [DayEntity] else { return 0 }
        guard let max = array.max(by: { $0.hours < $1.hours }) else { return 0 }
        let dayHours = (day.hours * 60 + day.minutes) / 60
        let maxHeight: CGFloat = CGFloat(max.hours + 3)
        return CGFloat(dayHours) / maxHeight * 100
    }
    
    func calculateHeight(_ month: MonthEntity, selectedTab: StatisticType) -> CGFloat? {
        switch selectedTab {
        case .hours:
            var hours: [Double] = []
            for month in monthViewModel.months {
                hours.append(month.totalHours)
            }
            let maxValue = hours.max(by: { $0 < $1 }) ?? 0
            let maxHeigh: CGFloat = CGFloat(maxValue + 30)
            return CGFloat(month.totalHours) / maxHeigh * 100
        case .workingDays:
            var days: [Int] = []
            for month in monthViewModel.months {
                days.append(month.day?.count ?? 0)
            }
            let maxValue = days.max(by: { $0 < $1 }) ?? 0
            let maxHeigh: CGFloat = CGFloat(maxValue + 5)
            return CGFloat(month.day?.count ?? 0) / maxHeigh * 100
        case .salary:
            var salary: [Double] = []
            for month in monthViewModel.months {
                salary.append(month.totalSalary)
            }
            let maxValue = salary.max(by: { $0 < $1 }) ?? 0
            let maxHeigh: CGFloat = CGFloat(maxValue + 3000)
            return CGFloat(month.totalSalary) / maxHeigh * 100
        }
    }
}
