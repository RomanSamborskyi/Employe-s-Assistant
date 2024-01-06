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
    @State var array: [DayEntity] = []
    let month: MonthEntity
    
    var body: some View {
        VStack {
            Text("\(month.title ?? "")")
            .font(.system(size: 15, weight: .bold, design: .rounded))
            Chart {
                ForEach(array, id: \.date) { hour in
                    BarMark(x: .value("Days", hour.date ?? Date(), unit: .day, calendar: .current),
                            y: .value("Hours", hour.hours)
                    ).foregroundStyle(Color.accentColor.gradient)
                }
            }
        }.onAppear {
            withAnimation(Animation.bouncy) {
                guard let array = month.day?.allObjects as? [DayEntity] else { return }
                self.array = array
            }
        }
        .onChange(of: vm.selectedIndex) { newValue in
            withAnimation(Animation.bouncy) {
                vm.currentMonth = vm.monthViewModel.months[newValue]
                guard let array = vm.currentMonth?.day?.allObjects as? [DayEntity] else { return }
                self.array = array
            }
        }
    }
}

#Preview {
    ChartView(vm: StatisticViewModel(), month: MonthEntity(context: CoreDataManager.instanse.context))
}
