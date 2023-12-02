//
//  ChartView.swift
//  Employe's Assistant
//
//  Created by Roman Samborskyi on 02.12.2023.
//

import SwiftUI
import Charts

struct ChartView: View {
    
   
    @ObservedObject var vm: StatisticViewModel
    @State private var selectedMonth: MonthEntity? = nil
    @State private var selectedIndex = 1
    @State var array: [DayEntity] = []
    
    var body: some View {
        VStack {
            Picker("Selected month", selection: $selectedIndex) {
                ForEach(vm.monthViewModel.months.indices) { index in
                    Text(vm.monthViewModel.months[index].title ?? "")
                }
            }
            .font(.system(size: 15, weight: .bold, design: .rounded))
                Chart {
                    ForEach(array, id: \.date) { hour in
                        BarMark(x: .value("Days", hour.date ?? Date(), unit: .day, calendar: .current),
                                y: .value("Hours", hour.hours)
                        ).foregroundStyle(Color.accentColor)
                    }
                }
        }.onAppear {
            self.selectedMonth = vm.monthViewModel.months[selectedIndex]
            guard let array = selectedMonth?.day?.allObjects as? [DayEntity] else { return }
            self.array = array
        }

    }
}

#Preview {
    ChartView(vm: StatisticViewModel())
}
