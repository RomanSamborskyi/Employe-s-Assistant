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
    @State var array: [Day] = []
    let month: Month
    let gradient: LinearGradient = LinearGradient(colors: [Color.accentColor, Color.clear], startPoint: .top, endPoint: .bottom)
    var body: some View {
        VStack {
            Text("\(month.title ?? "")")
                .font(.system(size: 15, weight: .bold, design: .rounded))
            
            Chart {
                ForEach(array, id: \.date) { hour in
                    LineMark(x: .value("Days", hour.date ?? Date(), unit: .day, calendar: .current),
                             y: .value("Hours", hour.hours ?? 0)
                    ).foregroundStyle(Color.accentColor.gradient)
                }
                ForEach(array, id: \.date) { hour in
                    PointMark(x: .value("Days", hour.date ?? Date(), unit: .day, calendar: .current),
                              y: .value("Hours", hour.hours ?? 0)
                    ).foregroundStyle(Color.accentColor.gradient)
                }
                ForEach(array, id: \.date) { hour in
                    AreaMark(x: .value("Days", hour.date ?? Date(), unit: .day, calendar: .current),
                             y: .value("Hours", hour.hours ?? 0)
                    ).foregroundStyle(gradient)
                }
            }
        }.onAppear {
            withAnimation(Animation.bouncy(duration: 0.5)) {
                guard let array = month.days else { return }
                self.array = array.sorted(by: { $0.date ?? Date() < $1.date ?? Date() })
            }
        }
        .onChange(of: vm.selectedIndex) { newValue in
            withAnimation(Animation.bouncy(duration: 0.5)) {
                vm.currentMonth = vm.months[newValue]
                guard let array = vm.currentMonth?.days else { return }
                self.array = array.sorted(by: { $0.date ?? Date() < $1.date ?? Date() })
            }
        }
    }
}
