//
//  StatisticByMonthsChartView.swift
//  Employe's Assistant
//
//  Created by Roman Samborskyi on 07.12.2023.
//

import SwiftUI
import Charts

struct StatisticByMonthsChartView: View {
    
    @ObservedObject var vm: StatisticViewModel
    @State private var array: [MonthEntity] = []
    @State var selectedTab: StatisticType = .hours
    
    var body: some View {
        VStack {
            Text("Statistic of \(selectedTab.description) by months")
                .font(.system(size: 15, weight: .bold, design: .rounded))
                .padding(5)
            Picker("", selection: $selectedTab) {
                ForEach(StatisticType.allCases, id: \.self) { tab in
                    Text(tab.description)
                }
            }.pickerStyle(.segmented)
                .padding(5)
            switch selectedTab {
            case .hours:
                Chart {
                    ForEach(array.reversed(), id: \.self) { month in
                        BarMark(x: .value("month", month.title!),
                                y: .value("total", month.totalHours)
                        )
                    }
                }
            case .workingDays:
                Chart {
                    ForEach(array.reversed(), id: \.self) { month in
                        BarMark(x: .value("month", month.title!),
                                y: .value("total", month.day?.count ?? 0)
                        )
                    }
                }
            case .salary:
                Chart {
                    ForEach(array.reversed(), id: \.self) { month in
                        BarMark(x: .value("month", month.title!),
                                y: .value("total", month.totalSalary)
                        )
                    }
                }
            }
        }.onAppear {
            withAnimation(Animation.bouncy) {
                self.array = vm.monthViewModel.months
            }
        }
    }
}

#Preview {
    StatisticByMonthsChartView(vm: StatisticViewModel())
}
