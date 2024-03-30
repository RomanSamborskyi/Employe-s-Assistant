//
//  LinearBartChartView.swift
//  Employee's Assistant
//
//  Created by Roman Samborskyi on 30.03.2024.
//

import SwiftUI
import Charts

struct LinearMarkChartView: View {
    
    @ObservedObject var vm: StatisticViewModel
    @State var array: [DayEntity] = []
    let month: MonthEntity
    let gradient: LinearGradient = LinearGradient(colors: [Color.accentColor, Color.clear], startPoint: .top, endPoint: .bottom)
    var body: some View {
        VStack {
            Text("\(month.title ?? "")")
                .font(.system(size: 15, weight: .bold, design: .rounded))
            ZStack {
                Chart {
                    ForEach(array, id: \.date) { hour in
                        LineMark(x: .value("Days", hour.date ?? Date(), unit: .day, calendar: .current),
                                 y: .value("Hours", hour.hours)
                        ).foregroundStyle(Color.accentColor.gradient)
                    }
                }
                Chart {
                    ForEach(array, id: \.date) { hour in
                        PointMark(x: .value("Days", hour.date ?? Date(), unit: .day, calendar: .current),
                                  y: .value("Hours", hour.hours)
                        ).foregroundStyle(Color.accentColor.gradient)
                    }
                }
                Chart {
                    ForEach(array, id: \.date) { hour in
                        AreaMark(x: .value("Days", hour.date ?? Date(), unit: .day, calendar: .current),
                                 y: .value("Hours", hour.hours)
                        ).foregroundStyle(gradient)
                    }
                }
            }
        }.onAppear {
            withAnimation(Animation.bouncy) {
                guard let array = month.day?.allObjects as? [DayEntity] else { return }
                self.array = array.sorted(by: { $0.date ?? Date() < $1.date ?? Date() })
            }
        }
        .onChange(of: vm.selectedIndex) { newValue in
            withAnimation(Animation.bouncy) {
                vm.currentMonth = vm.monthViewModel.months[newValue]
                guard let array = vm.currentMonth?.day?.allObjects as? [DayEntity] else { return }
                self.array = array.sorted(by: { $0.date ?? Date() < $1.date ?? Date() })
            }
        }
    }
}
