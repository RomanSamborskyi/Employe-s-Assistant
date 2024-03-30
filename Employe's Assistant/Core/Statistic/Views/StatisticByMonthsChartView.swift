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
    @Binding var chartType: ChartType
    
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
                switch chartType {
                case .barMark:
                    BartMarkChartView(vm: vm, selectedTab: $selectedTab)
                case .lineMark:
                    LinearMarkChartMontView(vm: vm, selectedTab: $selectedTab)
                case .custom:
                    SegmentedCustomChart(vm: vm, selectedTab: $selectedTab, array: array)
                }
            case .workingDays:
                switch chartType {
                case .barMark:
                    BartMarkChartView(vm: vm, selectedTab: $selectedTab)
                case .lineMark:
                    LinearMarkChartMontView(vm: vm, selectedTab: $selectedTab)
                case .custom:
                    SegmentedCustomChart(vm: vm, selectedTab: $selectedTab, array: array)
                }
            case .salary:
                switch chartType {
                case .barMark:
                    BartMarkChartView(vm: vm, selectedTab: $selectedTab)
                case .lineMark:
                    LinearMarkChartMontView(vm: vm, selectedTab: $selectedTab)
                case .custom:
                    SegmentedCustomChart(vm: vm, selectedTab: $selectedTab, array: array)
                }
              
            }
        }.onAppear {
            withAnimation(Animation.bouncy) {
                self.array = vm.monthViewModel.months
            }
        }
    }
}

struct SegmentedCustomChart: View {
    
    @ObservedObject var vm: StatisticViewModel
    @Binding var selectedTab: StatisticType
    let array: [MonthEntity]
    
    var body: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack(alignment: .bottom) {
                ForEach(array.reversed(), id: \.self) { month in
                    SegmentUniversalView(vm: vm, selectedTab: $selectedTab, month: month)
                }
            }
        }.frame(height: 130)
    }
}

struct SegmentUniversalView: View {
    
    @ObservedObject var vm: StatisticViewModel
    @State private var height: CGFloat = 0
    @State private var date: Date = Date()
    @State private var showDetail: Bool = false
    @Binding var selectedTab: StatisticType
    let month: MonthEntity
    
    var dateFormater: DateFormatter = {
        var formater: DateFormatter = DateFormatter()
        formater.dateFormat = "MMM.yy"
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
            Text(dateFormater.string(from: date))
                .font(.caption2)
                .frame(width: 30)
                .lineLimit(1)
                .minimumScaleFactor(0.7)
                .foregroundStyle(Color.gray)
        }
        .onAppear {
            if let height = vm.calculateHeight(month, selectedTab: selectedTab) {
                withAnimation(Animation.bouncy) {
                    self.height = height
                    self.date = vm.monthViewModel.getCurrentMont(month)
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

struct LinearMarkChartMontView: View {
    
    @ObservedObject var vm: StatisticViewModel
    @State private var array: [MonthEntity] = []
    @Binding var selectedTab: StatisticType
    let gradient: LinearGradient = LinearGradient(colors: [Color.accentColor, Color.clear], startPoint: .top, endPoint: .bottom)
    
    var body: some View {
        ZStack {
            Chart {
                ForEach(array, id: \.totalHours) { month in
                    switch selectedTab {
                    case .hours:
                        LineMark(x: .value("Months", month.title ?? ""),
                                 y: .value("Hours", month.totalHours)
                        ).foregroundStyle(Color.accentColor.gradient)
                    case .workingDays:
                        LineMark(x: .value("Months", month.title ?? ""),
                                 y: .value("Days", month.day?.count ?? 0)
                        ).foregroundStyle(Color.accentColor.gradient)
                    case .salary:
                        LineMark(x: .value("Months", month.title ?? ""),
                                 y: .value("Salary", month.totalSalary)
                        ).foregroundStyle(Color.accentColor.gradient)
                    }
                }
            }
            Chart {
                ForEach(array, id: \.totalHours) { month in
                    switch selectedTab {
                    case .hours:
                        PointMark(x: .value("Months", month.title ?? ""),
                                 y: .value("Hours", month.totalHours)
                        ).foregroundStyle(Color.accentColor.gradient)
                    case .workingDays:
                        PointMark(x: .value("Months", month.title ?? ""),
                                 y: .value("Days", month.day?.count ?? 0)
                        ).foregroundStyle(Color.accentColor.gradient)
                    case .salary:
                        PointMark(x: .value("Months", month.title ?? ""),
                                 y: .value("Salary", month.totalSalary)
                        ).foregroundStyle(Color.accentColor.gradient)
                    }
                }
            }
            Chart {
                ForEach(array, id: \.totalHours) { month in
                    switch selectedTab {
                    case .hours:
                        AreaMark(x: .value("Months", month.title ?? ""),
                                 y: .value("Hours", month.totalHours)
                        ).foregroundStyle(gradient)
                    case .workingDays:
                        AreaMark(x: .value("Months", month.title ?? ""),
                                 y: .value("Days", month.day?.count ?? 0)
                        ).foregroundStyle(gradient)
                    case .salary:
                        AreaMark(x: .value("Months", month.title ?? ""),
                                 y: .value("Salary", month.totalSalary)
                        ).foregroundStyle(gradient)
                    }
                }
            }
        }
        .onAppear {
            withAnimation(Animation.bouncy) {
                self.array = vm.monthViewModel.months.sorted { $0.date ?? Date() < $1.date ?? Date()
                }
            }
        }
    }
}

struct BartMarkChartView: View {
    
    @ObservedObject var vm: StatisticViewModel
    @State private var array: [MonthEntity] = []
    @Binding var selectedTab: StatisticType
    
    var body: some View {
        Chart {
            ForEach(array, id: \.totalHours) { month in
                switch selectedTab {
                case .hours:
                    BarMark(x: .value("Months", month.title ?? ""),
                             y: .value("Hours", month.totalHours)
                    ).foregroundStyle(Color.accentColor.gradient)
                case .workingDays:
                    BarMark(x: .value("Months", month.title ?? ""),
                             y: .value("Days", month.day?.count ?? 0)
                    ).foregroundStyle(Color.accentColor.gradient)
                case .salary:
                    BarMark(x: .value("Months", month.title ?? ""),
                             y: .value("Salary", month.totalSalary)
                    ).foregroundStyle(Color.accentColor.gradient)
                }
            }
        }
        .onAppear {
            withAnimation(Animation.bouncy) {
                self.array = vm.monthViewModel.months.sorted { $0.date ?? Date() < $1.date ?? Date()
                }
            }
        }
    }
}
