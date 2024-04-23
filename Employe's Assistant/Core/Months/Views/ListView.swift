//
//  ListView.swift
//  Employee's Assistant
//
//  Created by Roman Samborskyi on 03.02.2024.
//

import SwiftUI
import WidgetKit


struct ListView: View {
    
    @ObservedObject var vm: MonthsViewModel
    @State var month: Month
    var dateFormater: DateFormatter = {
        let dateFormater = DateFormatter()
        dateFormater.dateStyle = .medium
        return dateFormater
    }()
    
    var body: some View {
        List {
            if let array = vm.months.first(where: { $0.title == month.title })?.days {
                if !array.isEmpty {
                    Section {
                        ProgresBarView(vm: vm, month: month)
                    }
                    ForEach(array.sorted(by: { $0.date! > $1.date! })) { day in
                        NavigationLink(destination: { MoreDetailsOfDayView(day: day) }, label: {
                            HStack {
                                Text(dateFormater.string(from: day.date ?? Date()))
                                Spacer()
                                Text("\(day.hours ?? 0):\(day.minutes ?? 0)")
                            }
                        }).contextMenu {
                            Button(role: .destructive, action: {
                                vm.deleteDay(month: month, day: day)
                                WidgetCenter.shared.reloadAllTimelines()
                            },label: {
                                HStack {
                                    Text("Delete")
                                    Spacer()
                                    Image(systemName: "trash")
                                }
                            })
                        }
                    }
                }
            }
        }
    }
}

