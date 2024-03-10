//
//  CustomChartView.swift
//  Employee's Assistant
//
//  Created by Roman Samborskyi on 10.03.2024.
//

import SwiftUI

struct CustomChartView: View {
    
    @ObservedObject var vm: StatisticViewModel
    @State var array: [DayEntity] = []
    @State private var maxValue: Int32 = 0
    @State private var minValue: Int32 = 0
    @State private var offsetMaxValue: CGFloat = 0
    @State private var offsetMinValue: CGFloat = 0
    let month: MonthEntity
    
    var body: some View {
        VStack {
            Text("\(month.title ?? "")")
                .font(.system(size: 15, weight: .bold, design: .rounded))
            HStack(alignment: .bottom) {
                ZStack {
                    Text("\(maxValue)")
                        .offset(y: offsetMaxValue)
                    Text("\(minValue)")
                        .offset(y: offsetMinValue)
                    Text("0")
                        .offset(y: 5)
                }.font(.caption2)
                    .frame(width: 15)
                    .lineLimit(1)
                    .minimumScaleFactor(0.7)
                ForEach(array) { day in
                    SegmentView(vm: vm, day: day)
                }
            }
        }.onAppear {
            if let array = month.day?.allObjects as? [DayEntity] {
                withAnimation(Animation.bouncy) {
                    self.array = array.sorted(by: { $0.date! < $1.date! })
                    if let max = array.max(by: { $0.hours < $1.hours }), let min = array.min(by: { $0.hours < $1.hours }) {
                        self.maxValue = max.hours
                        self.minValue = min.hours
                        self.offsetMaxValue = (CGFloat(max.hours) / CGFloat(max.hours + 3) * (-100))
                        self.offsetMinValue = (CGFloat(min.hours) / CGFloat(max.hours + 3) * (-100))
                    }
                }
            }
        }
        .onChange(of: vm.selectedIndex) { index in
            withAnimation(Animation.bouncy) {
                vm.currentMonth = vm.monthViewModel.months[index]
                guard let array = vm.currentMonth?.day?.allObjects as? [DayEntity] else { return }
                self.array = array.sorted(by: { $0.date! < $1.date! })
                if let max = array.max(by: { $0.hours < $1.hours }), let min = array.min(by: { $0.hours < $1.hours }) {
                    self.maxValue = max.hours
                    self.minValue = min.hours
                    self.offsetMaxValue = (CGFloat(max.hours) / CGFloat(max.hours + 3) * (-100))
                    self.offsetMinValue = (CGFloat(min.hours) / CGFloat(max.hours + 3) * (-100))
                }
            }
        }
    }
}

#Preview {
    CustomChartView(vm: StatisticViewModel(), month: MonthEntity(context: CoreDataManager.instanse.context))
}

struct SegmentView: View {
    
    @ObservedObject var vm: StatisticViewModel
    @State private var height: CGFloat = 0
    let day: DayEntity
    
    var body: some View {
        VStack {
            RoundedRectangle(cornerRadius: 15)
                .frame(maxWidth: .infinity)
                .frame(height: height)
                .foregroundStyle(Color.accentColor)
        }.onAppear {
            withAnimation(Animation.bouncy) {
                if let height = vm.calculateSegmentHeight(day: day) {
                    self.height = height
                }
            }
        }
    }
}
