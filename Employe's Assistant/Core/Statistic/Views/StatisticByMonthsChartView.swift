//
//  StatisticByMonthsChartView.swift
//  Employe's Assistant
//
//  Created by Roman Samborskyi on 07.12.2023.
//

import SwiftUI
import Charts

struct StatisticByMonthsChartView: View {
    
    @ObservedObject var vm: StatisticViewModel
    @State private var array: [MonthEntity] = []
    @State var selectedTab: StatisticType = .hours
    
    var body: some View {
        VStack {
            Text("Statistic by months")
                .font(.system(size: 15, weight: .bold, design: .rounded))
                .padding(5)
            Picker("", selection: $selectedTab) {
                ForEach(StatisticType.allCases, id: \.self) { tab in
                    Text(tab.description)
                }
            }.pickerStyle(.segmented)
                .padding(5)
            switch selectedTab {
            case .hours:
                ScrollView(.horizontal, showsIndicators: false) {
                    HStack(alignment: .bottom) {
                        ForEach(array.reversed(), id: \.self) { month in
                            SegmentUniversalView(vm: vm, selectedTab: $selectedTab, month: month)
                        }
                    }
                }.frame(height: 130)
            case .workingDays:
                ScrollView(.horizontal, showsIndicators: false) {
                    HStack(alignment: .bottom) {
                        ForEach(array.reversed(), id: \.self) { month in
                            SegmentUniversalView(vm: vm, selectedTab: $selectedTab, month: month)
                        }
                    }
                }.frame(height: 130)
            case .salary:
                ScrollView(.horizontal, showsIndicators: false) {
                    HStack(alignment: .bottom) {
                        ForEach(array.reversed(), id: \.self) { month in
                            SegmentUniversalView(vm: vm, selectedTab: $selectedTab, month: month)
                        }
                    }
                }.frame(height: 130)
            }
        }.onAppear {
            withAnimation(Animation.bouncy) {
                self.array = vm.monthViewModel.months
            }
        }
    }
}

#Preview {
    StatisticByMonthsChartView(vm: StatisticViewModel())
}

struct SegmentUniversalView: View {
    
    @ObservedObject var vm: StatisticViewModel
    @State private var height: CGFloat = 0
    @State private var showDetail: Bool = false
    @Binding var selectedTab: StatisticType
    let month: MonthEntity
    
    var dateFormater: DateFormatter = {
        var formater: DateFormatter = DateFormatter()
        formater.dateFormat = "M.yy"
        return formater
    }()
    
    var detailTitle: String {
        switch selectedTab {
        case .hours:
            return "\(month.totalHours)"
        case .workingDays:
            return "\(month.day?.count ?? 0)"
        case .salary:
            return "\(month.totalSalary)"
        }
    }
    
    var body: some View {
        VStack {
            if showDetail {
                Text(detailTitle)
                    .padding(5)
                    .font(.caption)
                    .animation(.bouncy, value: showDetail)
                    .background(
                     RoundedRectangle(cornerRadius: 10)
                        .foregroundStyle(Color.accentColor.opacity(0.4))
                    )
            }
            RoundedRectangle(cornerRadius: 10)
                .frame(width: 30)
                .frame(height: height)
                .foregroundStyle(Color.accentColor)
            Text(dateFormater.string(from: month.date ?? Date()))
                .font(.caption2)
                .foregroundStyle(Color.gray)
        }
        .onAppear {
            if let height = vm.calculateHeight(month, selectedTab: selectedTab) {
                withAnimation(Animation.bouncy) {
                    self.height = height
                }
            }
        }
        .onTapGesture {
            withAnimation(Animation.bouncy) {
                self.showDetail.toggle()
            }
        }
    }
}
