//
//  MonthDetailView.swift
//  Hours
//
//  Created by Roman Samborskyi on 10.11.2023.
//

import SwiftUI



struct MonthDetailView: View {
    
    @State private var count: Int = 0
    @ObservedObject var vm: StatisticViewModel
    let month: MonthEntity
    
    var body: some View {
        HStack {
            ZStack {
                Circle()
                    .stroke(Color.gray.opacity(0.5),style: StrokeStyle(lineWidth: 10, lineCap: .round))
                    .frame(width: 95)
                Circle()
                    .trim(from: 0.0 , to: CGFloat(month.trim))
                    .stroke(Color.green,style: StrokeStyle(lineWidth: 10, lineCap: .round))
                    .frame(width: 95)
                    .rotationEffect(Angle(degrees: 270.0))
                    .animation(.linear, value: 0.2)
                if Int32(month.totalHours) >= month.monthTarget {
                        Circle()
                        .stroke(Color.green.gradient.opacity(0.3), style: StrokeStyle(lineWidth: 10, lineCap: .round, lineJoin: .round))
                            .frame(width: 105)
                            .blur(radius: 0.5)
                }
                Text(vm.monthViewModel.countHoursTitle(for: month))
                    .font(.system(size: 25, weight: .bold, design: .rounded))
                    .frame(width: 80)
                    .lineLimit(1)
                    .minimumScaleFactor(0.7)
            }.frame(width: 110, height: 110)
            VStack(alignment: .leading) {
                HStack {
                    Text("Month details")
                        .font(.title2)
                        .fontWeight(.bold)
                    Image(systemName: "info.bubble.fill")
                        .symbolRenderingMode(.hierarchical)
                        .foregroundStyle(Color.accentColor)
                        .font(.title2)
                }
                HStack {
                    Text("Count of working days:")
                        .foregroundColor(.red.opacity(0.7))
                        .font(.caption)
                    Spacer(minLength: 25)
                    Text("\(count)")
                        .foregroundStyle(Color.red)
                }
                HStack {
                    Text("Total salary:")
                        .foregroundColor(.green.opacity(0.7))
                        .font(.caption)
                        Spacer(minLength: 35)
                    Text(String(format: "%.2f", vm.monthViewModel.countSalary(for: month)))
                        .foregroundStyle(Color.green)
                        .lineLimit(1)
                        .minimumScaleFactor(0.8)
                }
                HStack {
                    Text("Month target:")
                        .font(.caption)
                        .foregroundColor(vm.monthViewModel.settings.newAccentColor)
                    Spacer(minLength: 25)
                    Text("\(month.monthTarget)")
                        .foregroundStyle(vm.monthViewModel.settings.newAccentColor)
                }
            }.onAppear {
                withAnimation(Animation.spring) {
                    if let array = month.day?.allObjects as? [DayEntity] {
                        self.count = array.count
                    }
                    vm.trimCalculation(for: month)
                }
           }
            .onChange(of: vm.currentMonth, perform: { month in
                withAnimation(Animation.spring) {
                    if let array = month?.day?.allObjects as? [DayEntity] {
                        self.count = array.count
                    }
                }
            })
        }
    }
}

#Preview {
    MonthDetailView(vm: StatisticViewModel(), month: MonthEntity(context: CoreDataManager().context))
}
