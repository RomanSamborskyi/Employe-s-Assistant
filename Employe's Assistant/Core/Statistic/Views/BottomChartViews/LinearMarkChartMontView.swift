//
//  LinearMarkChartMontView.swift
//  Employee's Assistant
//
//  Created by Roman Samborskyi on 30.03.2024.
//

import SwiftUI
import Charts


struct LinearMarkChartMontView: View {
    
    @ObservedObject var vm: StatisticViewModel
    @State private var array: [Month] = []
    @Binding var selectedTab: StatisticType
    let gradient: LinearGradient = LinearGradient(colors: [Color.accentColor, Color.clear], startPoint: .top, endPoint: .bottom)
    
    var body: some View {
        ZStack {
            Chart {
                ForEach(array, id: \.totalHours) { month in
                    switch selectedTab {
                    case .hours:
                        LineMark(x: .value("Months", month.title ?? ""),
                                 y: .value("Hours", month.totalHours ?? 0)
                        ).foregroundStyle(Color.accentColor.gradient)
                    case .workingDays:
                        LineMark(x: .value("Months", month.title ?? ""),
                                 y: .value("Days", month.days?.count ?? 0)
                        ).foregroundStyle(Color.accentColor.gradient)
                    case .salary:
                        LineMark(x: .value("Months", month.title ?? ""),
                                 y: .value("Salary", month.totalSalary ?? 0)
                        ).foregroundStyle(Color.accentColor.gradient)
                    }
                }
            }
            Chart {
                ForEach(array, id: \.totalHours) { month in
                    switch selectedTab {
                    case .hours:
                        PointMark(x: .value("Months", month.title ?? ""),
                                 y: .value("Hours", month.totalHours ?? 0)
                        ).foregroundStyle(Color.accentColor.gradient)
                    case .workingDays:
                        PointMark(x: .value("Months", month.title ?? ""),
                                 y: .value("Days", month.days?.count ?? 0)
                        ).foregroundStyle(Color.accentColor.gradient)
                    case .salary:
                        PointMark(x: .value("Months", month.title ?? ""),
                                 y: .value("Salary", month.totalSalary ?? 0)
                        ).foregroundStyle(Color.accentColor.gradient)
                    }
                }
            }
            Chart {
                ForEach(array, id: \.totalHours) { month in
                    switch selectedTab {
                    case .hours:
                        AreaMark(x: .value("Months", month.title ?? ""),
                                 y: .value("Hours", month.totalHours ?? 0)
                        ).foregroundStyle(gradient)
                    case .workingDays:
                        AreaMark(x: .value("Months", month.title ?? ""),
                                 y: .value("Days", month.days?.count ?? 0)
                        ).foregroundStyle(gradient)
                    case .salary:
                        AreaMark(x: .value("Months", month.title ?? ""),
                                 y: .value("Salary", month.totalSalary ?? 0)
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
