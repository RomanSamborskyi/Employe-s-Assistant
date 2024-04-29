//
//  StatisticViewModel.swift
//  Employe's Assistant
//
//  Created by Roman Samborskyi on 02.12.2023.
//

import Foundation
import Combine
import SwiftUI


class StatisticViewModel: ObservableObject {

    @Published var months: [Month] = []
    let monthViewModel: MonthsViewModel
    @Published var currentMonth: Month? = nil
    @Published var selectedIndex: Int = 0
    @Published var newAccentColor: Color = .accentColor
    var cancellable = Set<AnyCancellable>()
    private let key: String = "color"

 
    init(monthViewModel: MonthsViewModel) {
        self.monthViewModel = monthViewModel
        getMonths()
        getCurrentMonth()
        getColor()
       
    }
    
    func getColor() {
        guard let components = UserDefaults.standard.value(forKey: key) as? [CGFloat] else { return }
        let color = Color(.sRGB, red: components[0], green: components[1], blue: components[2], opacity: components[3] )
        DispatchQueue.main.async {
            self.newAccentColor = color
        }
    }
    
    func getMonths() {
        monthViewModel.$months
           .sink { [weak self] month in
            self?.months = month
            }
           .store(in: &cancellable)
    }
    
    var dateFormater: DateFormatter = {
        var dateFormater: DateFormatter = DateFormatter()
        dateFormater.dateFormat = "LLLL yyyy"
        return dateFormater
    }()
    
    func trimCalculation(for month: Month) -> CGFloat {
        if let month = months.first(where: { $0.title == month.title }) {
            let hours = month.totalHours ?? 0
            let scorePercent = CGFloat(hours) / CGFloat(month.monthTarget ?? 0) * CGFloat(100)
            let currentTrim: CGFloat = CGFloat(scorePercent) / CGFloat(1.0) / CGFloat(100)
            return currentTrim
        }
        return 0
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
        self.currentMonth = self.months[index]
        self.selectedIndex = index
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
