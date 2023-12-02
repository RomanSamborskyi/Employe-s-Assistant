//
//  ChartView.swift
//  Employe's Assistant
//
//  Created by Roman Samborskyi on 02.12.2023.
//

import SwiftUI
import Charts

struct ChartView: View {
    
    let month: MonthEntity
    @ObservedObject var vm: StatisticViewModel = StatisticViewModel()
    @State private var selectedMonth: Monthes = .december
    
    var body: some View {
        VStack {
            Text("Some text under the chart")
                .font(.system(size: 15, weight: .bold, design: .rounded))
            if let array = month.day?.allObjects as? [DayEntity] {
                Chart {
                    ForEach(array, id: \.date) { hour in
                        BarMark(x: .value("Days", hour.date ?? Date(), unit: .day, calendar: .current),
                                y: .value("Hours", hour.hours)
                        ).foregroundStyle(Color.accentColor)
                    }
                }
            }
        }
    }
}

#Preview {
    ChartView(month: MonthEntity(context: CoreDataManager().context))
}
