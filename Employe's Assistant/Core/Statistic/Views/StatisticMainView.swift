//
//  StatisticMainView.swift
//  Employe's Assistant
//
//  Created by Roman Samborskyi on 01.12.2023.
//

import SwiftUI

struct StatisticMainView: View {
    
    @StateObject var vm: StatisticViewModel = StatisticViewModel()
    @State private var showMonth: Bool = false
    
    var body: some View {
        NavigationView {
            if !vm.monthViewModel.months.isEmpty {
                List {
                    Section {
                        MonthDetailView(vm: vm, month: vm.currentMonth ?? vm.monthViewModel.months.first!)
                    }
                    Section {
                        ChartView(vm: vm, month: vm.currentMonth ?? vm.monthViewModel.months.first!)
                    }
                    Section {
                        StatisticByMonthsChartView(vm: vm)
                    }
                }.navigationTitle("Statistic")
                    .toolbar {
                        ToolbarItem(placement: .topBarTrailing) {
                            Picker("Selected month", selection: $vm.selectedIndex) {
                                ForEach(vm.monthViewModel.months.indices, id: \.self) { index in
                                    Text(vm.monthViewModel.months[index].title ?? "")
                                }
                            }
                        }
                    }
            } else {
                VStack {
                    Image(systemName: "chart.xyaxis.line")
                        .padding()
                        .font(.system(size: 55, weight: .bold, design: .rounded))
                        .foregroundStyle(Color.accentColor)
                    Text("There is no any statistic")
                        .padding()
                        .font(.system(size: 25, weight: .bold, design: .rounded))
                }.navigationTitle("Statistic")
                    
            }
        }
    }
}

#Preview {
    StatisticMainView()
}
