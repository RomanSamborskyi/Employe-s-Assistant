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
    @State var array: [Day] = []
    let month: Month
    
    var body: some View {
        VStack {
            Text("\(month.title ?? "")")
            .font(.system(size: 15, weight: .bold, design: .rounded))
            Chart {
                ForEach(array, id: \.date) { hour in
                    BarMark(x: .value("Days", hour.date ?? Date(), unit: .day, calendar: .current),
                            y: .value("Hours", hour.hours ?? 0)
                    ).foregroundStyle(Color.newAccentColor.gradient)
                }
            }
        }
        .onAppear {
            withAnimation(Animation.bouncy(duration: 0.5)) {
                guard let days = month.days else { return }
                self.array = days.sorted(by: { $0.date ?? Date() < $1.date ?? Date() })
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
