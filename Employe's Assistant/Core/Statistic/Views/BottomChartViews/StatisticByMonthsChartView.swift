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
    @State var selectedTab: StatisticType = .hours
    @Binding var chartType: ChartType
    
    var body: some View {
        VStack {
            Text("Statistic by months")
                .font(.system(size: 15, weight: .bold, design: .rounded))
                .padding(5)
            Picker("", selection: $selectedTab) {
                ForEach(StatisticType.allCases, id: \.self) { tab in
                    Text(tab.description)
                }
            }
            .pickerStyle(.segmented)
                .padding(5)
            switch selectedTab {
            case .hours:
                switch chartType {
                case .barMark:
                    BartMarkChartView(vm: vm, selectedTab: $selectedTab)
                case .lineMark:
                    LinearMarkChartMontView(vm: vm, selectedTab: $selectedTab)
                case .custom:
                    SegmentedCustomChart(vm: vm, selectedTab: $selectedTab)
                }
            case .workingDays:
                switch chartType {
                case .barMark:
                    BartMarkChartView(vm: vm, selectedTab: $selectedTab)
                case .lineMark:
                    LinearMarkChartMontView(vm: vm, selectedTab: $selectedTab)
                case .custom:
                    SegmentedCustomChart(vm: vm, selectedTab: $selectedTab)
                }
            case .salary:
                switch chartType {
                case .barMark:
                    BartMarkChartView(vm: vm, selectedTab: $selectedTab)
                case .lineMark:
                    LinearMarkChartMontView(vm: vm, selectedTab: $selectedTab)
                case .custom:
                    SegmentedCustomChart(vm: vm, selectedTab: $selectedTab)
                }
              
            }
        }
    }
}

