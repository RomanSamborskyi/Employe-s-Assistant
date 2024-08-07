//
//  StatisticMainView.swift
//  Employe's Assistant
//
//  Created by Roman Samborskyi on 01.12.2023.
//

import SwiftUI

struct StatisticMainView: View {
    
    @StateObject var vm: StatisticViewModel
    @AppStorage("savedType") var chartType: ChartType = .barMark
    
    init(dataManager: DataManager) {
        _vm = StateObject(wrappedValue: StatisticViewModel(monthViewModel: MonthsViewModel(dataManager: dataManager), dataManager: dataManager))
    }
    
    var body: some View {
        NavigationStack {
            if !vm.months.isEmpty {
                List {
                    Section {
                        MonthDetailView(vm: vm, month: vm.currentMonth ?? vm.months.first!)
                    }
                    Section {
                        switch chartType {
                        case .barMark:
                            ChartView(vm: vm, month: vm.currentMonth ?? vm.months.first!)
                        case .lineMark:
                            LinearMarkChartView(vm: vm, month: vm.currentMonth ?? vm.months.first!)
                        case .custom:
                            CustomChartView(vm: vm, month: vm.currentMonth ?? vm.months.first!)
                        }
                    }
                    .overlay {
                        if vm.currentMonth?.totalHours == 0 {
                            VStack(spacing: 15) {
                                Image(systemName: "chart.xyaxis.line")
                                    .font(.largeTitle)
                                Text("No data to display")
                                    .font(.title2)
                            }
                            .padding(10)
                            .fontWeight(.bold)
                        }
                    }
                    Section {
                        StatisticByMonthsChartView(vm: vm, chartType: $chartType)
                    }
                }
                .navigationTitle("Statistic")
                .toolbar {
                    ToolbarItem(placement: .topBarTrailing) {
                        Picker("Selected month", selection: $vm.selectedIndex) {
                            ForEach(vm.months.indices, id: \.self) { index in
                                Text(vm.months[index].title ?? "")
                            }
                        }
                    }
                    if #available(iOS 16, *) {
                        ToolbarItem(placement: .topBarLeading) {
                            Picker("", selection: $chartType) {
                                ForEach(ChartType.allCases) { chart in
                                    Text(chart.description)
                                        .tag(chart)
                                }
                            }
                        }
                    }
                }
            } else if vm.startFetchingData == true {
                ProgressView()
                    .scaleEffect(1.5)
            } else {
                VStack {
                    Image(systemName: "chart.xyaxis.line")
                        .padding()
                        .font(.system(size: 55, weight: .bold, design: .rounded))
                        .foregroundStyle(Color.newAccentColor)
                    Text("There is no any statistic")
                        .padding()
                        .font(.system(size: 25, weight: .bold, design: .rounded))
                }
                .navigationTitle("Statistic")
            }
        }
    }
}
