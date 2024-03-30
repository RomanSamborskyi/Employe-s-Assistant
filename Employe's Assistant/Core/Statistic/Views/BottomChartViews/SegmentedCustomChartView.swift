//
//  SegmentedCustomChartView.swift
//  Employee's Assistant
//
//  Created by Roman Samborskyi on 30.03.2024.
//

import SwiftUI

struct SegmentedCustomChart: View {
    
    @ObservedObject var vm: StatisticViewModel
    @Binding var selectedTab: StatisticType
    @State private var array: [MonthEntity] = []
    
    var body: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack(alignment: .bottom) {
                ForEach(array.reversed(), id: \.self) { month in
                    SegmentUniversalView(vm: vm, selectedTab: $selectedTab, month: month)
                }
            }
        }.frame(height: 130)
            .onAppear {
                withAnimation(Animation.bouncy) {
                    self.array = vm.monthViewModel.months
                }
            }
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
