//
//  StatisticViewModel.swift
//  Employe's Assistant
//
//  Created by Roman Samborskyi on 02.12.2023.
//

import Foundation
import CoreData
import Combine

class StatisticViewModel: ObservableObject {
    
    let monthViewModel: MonthsViewModel = MonthsViewModel.instance
    @Published var months: [Month] = []
    @Published var currentMonth: Month?
    @Published var selectedIndex: Int = 0
    var cancellable = Set<AnyCancellable>()
 
    init() {
        getMonths()
        getCurrentMonth()
        trimCalculation()
    }
    
    var dateFormater: DateFormatter = {
        var dateFormater: DateFormatter = DateFormatter()
        dateFormater.dateFormat = "LLLL yyyy"
        return dateFormater
    }()
    
    func getMonths() {
        monthViewModel.$months
            .subscribe(on: DispatchQueue.main)
            .sink { [weak self] array in
                self?.months = array
            }
            .store(in: &cancellable)
    }
    
    func localizedMonthTitle(title: String?) -> String {
        guard let title = title else { return "" }
        let indexOfSpace = title.firstIndex(of: " ") ?? title.endIndex
        let clearTitle = title[..<indexOfSpace]
        let yaer = title[indexOfSpace...]
        return NSLocalizedString(String(clearTitle), comment: "") + String(yaer)
    }
    
    func getCurrentMonth() {
        guard let index = self.months.firstIndex(where: { self.localizedMonthTitle(title: $0.title) == self.dateFormater.string(from: Date()).capitalized }) else {
                return
            }
            let month = self.months[index]
            self.selectedIndex = index
            self.currentMonth = month
    }
    
    func trimCalculation() {
        if var month = currentMonth {
            let hours = month.totalHours ?? 0
            let scorePercent = CGFloat(hours) / CGFloat(month.monthTarget ?? 0) * CGFloat(100)
            let currentTrim: CGFloat = CGFloat(scorePercent) / CGFloat(1.0) / CGFloat(100)
            month.trim = currentTrim
        }
    }
    
    func calculateSegmentHeight(day: Day) -> CGFloat? {
        guard let array = currentMonth?.days else { return nil }
        guard let max = array.max(by: { $0.hours ?? 0 < $1.hours ?? 0 }) else { return 0 }
        let dayHours = ((day.hours ?? 0) * 60 + (day.minutes ?? 0)) / 60
        let maxHeight: CGFloat = CGFloat((max.hours ?? 0) + 3)
        return CGFloat(dayHours) / maxHeight * 100
    }
    
    func calculateHeight(_ month: Month, selectedTab: StatisticType) -> CGFloat? {
        switch selectedTab {
        case .hours:
            var hours: [Double] = []
            for month in months {
                hours.append(month.totalHours ?? 0)
            }
            let maxValue = hours.max(by: { $0 < $1 }) ?? 0
            let maxHeigh: CGFloat = CGFloat(maxValue + 30)
            return CGFloat(month.totalHours ?? 0) / maxHeigh * 100
        case .workingDays:
            var days: [Int] = []
            for month in months {
                days.append(month.days?.count ?? 0)
            }
            let maxValue = days.max(by: { $0 < $1 }) ?? 0
            let maxHeigh: CGFloat = CGFloat(maxValue + 5)
            return CGFloat(month.days?.count ?? 0) / maxHeigh * 100
        case .salary:
            var salary: [Double] = []
            for month in months {
                salary.append(month.totalSalary ?? 0)
            }
            let maxValue = salary.max(by: { $0 < $1 }) ?? 0
            let maxHeigh: CGFloat = CGFloat(maxValue + 3000)
            return CGFloat(month.totalSalary ?? 0) / maxHeigh * 100
        }
    }
}
