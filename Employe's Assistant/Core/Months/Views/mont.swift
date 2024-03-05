//
//  mont.swift
//  Employee's Assistant
//
//  Created by Roman Samborskyi on 02.03.2024.
//

import SwiftUI

struct mont: View {
    @StateObject private var viewModel: MonthsViewModel = MonthsViewModel()
    var body: some View {
        NavigationStack {
            List {
                ForEach(viewModel.months1) { month in
                    NavigationLink(destination: { Detail(vm: viewModel, month: month) }, label: {
                        HStack {
                            Text(month.title)
                            Spacer()
                            // MonthProgressBarView(vm: viewModel, month: month)
                        }
                    })
                }.onDelete(perform: { indexSet in
                    viewModel.deleteMonth(indexSet: indexSet)
                })
            }.navigationTitle("Title")
        }
    }
}

#Preview {
    mont()
}

struct Detail: View {
    @ObservedObject var vm: MonthsViewModel
    let month: Months
    
    var dateFormater: DateFormatter = {
        let dateFormater = DateFormatter()
        dateFormater.dateStyle = .medium
        return dateFormater
    }()
    
    var body: some View {
        List {
            ForEach(month.days.sorted(by: {$0.date > $1.date})) { day in
                    HStack {
                        Text(dateFormater.string(from: day.date))
                        Spacer()
                        Text("\(day.hours):\(day.minutes)")
                    }.contextMenu {
                        Button(role: .destructive, action: {
                            vm.deleteDay2(month: month, day: day)
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
