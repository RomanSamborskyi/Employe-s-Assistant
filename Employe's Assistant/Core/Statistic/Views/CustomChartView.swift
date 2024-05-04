//
//  CustomChartView.swift
//  Employee's Assistant
//
//  Created by Roman Samborskyi on 10.03.2024.
//

import SwiftUI

struct CustomChartView: View {
    
    @ObservedObject var vm: StatisticViewModel
    @State var array: [Day] = []
    let month: Month
    
    var body: some View {
        VStack {
            Text("\(month.title ?? "")")
                .font(.system(size: 15, weight: .bold, design: .rounded))
                ScrollView(.horizontal, showsIndicators: false) {
                    HStack(alignment: .bottom) {
                        ForEach(array) { day in
                            SegmentView(vm: vm, day: day)
                        }
                    }
                }.frame(height: 130)
        }
        .onAppear {
            withAnimation(Animation.bouncy(duration: 0.5)) {
                guard let month = vm.months.first(where: { $0.title == month.title }),
                      let days = month.days else { return }
                self.array = days.sorted(by: { $0.date ?? Date() < $1.date ?? Date() })
            }
        }
        .onChange(of: vm.selectedIndex) { index in
            withAnimation(Animation.bouncy) {
                vm.currentMonth = vm.months[index]
                guard let array = vm.currentMonth?.days else { return }
                self.array = array.sorted(by: { $0.date ?? Date() < $1.date ?? Date() })
            }
        }
    }
}


struct SegmentView: View {
    
    @ObservedObject var vm: StatisticViewModel
    @State private var height: CGFloat = 0
    @State private var showHours: Bool = false
    let day: Day
    var dateFormater: DateFormatter = {
        var formater: DateFormatter = DateFormatter()
        formater.dateStyle = .medium
        formater.dateFormat = "d.MMM"
        return formater
    }()
    var body: some View {
        VStack {
            if showHours {
                Text("\(day.hours ?? 0):\(day.minutes ?? 0)")
                    .padding(5)
                    .font(.caption)
                    .animation(.bouncy, value: showHours)
                    .background(
                     RoundedRectangle(cornerRadius: 10)
                        .foregroundStyle(Color.accentColor.opacity(0.4))
                    )
            }
            RoundedRectangle(cornerRadius: 10)
                .frame(width: 25)
                .frame(height: height)
                .foregroundStyle(Color.accentColor)
            Text(dateFormater.string(from: day.date ?? Date()))
                .font(.system(size: 7))
                .frame(width: 25)
                .foregroundStyle(Color.gray)
        }
        .onAppear {
            if let height = vm.calculateSegmentHeight(day: day) {
                withAnimation(Animation.bouncy) {
                    self.height = height
                }
            }
        }
        .onTapGesture {
            withAnimation(Animation.bouncy) {
                self.showHours.toggle()
            }
        }
    }
}
