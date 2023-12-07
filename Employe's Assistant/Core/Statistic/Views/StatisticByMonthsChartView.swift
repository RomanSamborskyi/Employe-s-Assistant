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
    
    var body: some View {
        VStack {
            Chart {
                ForEach(vm.monthViewModel.months, id: \.self) { month in
                    LineMark(x: .value("month", month.title!),
                             y: .value("total", month.totalHours)
                    )
                }
            }
        }
    }
}

#Preview {
    StatisticByMonthsChartView(vm: StatisticViewModel())
}
