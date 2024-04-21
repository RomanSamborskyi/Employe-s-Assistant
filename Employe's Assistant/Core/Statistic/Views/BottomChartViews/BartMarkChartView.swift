//
//  BartMarkChartView.swift
//  Employee's Assistant
//
//  Created by Roman Samborskyi on 30.03.2024.
//

import SwiftUI
import Charts


struct BartMarkChartView: View {
    
    @ObservedObject var vm: StatisticViewModel
    @State private var array: [Month] = []
    @Binding var selectedTab: StatisticType
    
    var body: some View {
        Chart {
            ForEach(array, id: \.totalHours) { month in
                switch selectedTab {
                case .hours:
                    BarMark(x: .value("Months", month.title ?? ""),
                             y: .value("Hours", month.totalHours ?? 0)
                    ).foregroundStyle(Color.accentColor.gradient)
                case .workingDays:
                    BarMark(x: .value("Months", month.title ?? ""),
                             y: .value("Days", month.days?.count ?? 0)
                    ).foregroundStyle(Color.accentColor.gradient)
                case .salary:
                    BarMark(x: .value("Months", month.title ?? ""),
                             y: .value("Salary", month.totalSalary ?? 0)
                    ).foregroundStyle(Color.accentColor.gradient)
                }
            }
        }
        .onAppear {
            withAnimation(Animation.bouncy) {
                self.array = vm.monthViewModel.months.sorted { $0.date ?? Date() < $1.date ?? Date()
                }
            }
        }
    }
}
