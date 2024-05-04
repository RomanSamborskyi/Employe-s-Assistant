//
//  DayDetailView.swift
//  Employe's Assistant
//
//  Created by Roman Samborskyi on 01.12.2023.
//

import SwiftUI

struct DayDetailView: View {
 
    @ObservedObject var vm: MonthsViewModel
    @State private var addNewDay: Bool = false
    @AppStorage("selectedView") var selectedView: SelectView = .list
    let month: Month
    
    var body: some View {
        VStack {
            switch selectedView {
            case .list:
                ListView(vm: vm, month: month)
            case .calendar:
                CalendarView(vm: vm, month: month)
            }
        }.onAppear {
            vm.dataManager.updateTotalSalaryAndHours(month: month, totalSalary: vm.countSalary(for: month) ?? 0, totalHours: vm.countHours(for: month) ?? 0)
            vm.getMonths()
        }
        .toolbar {
            ToolbarItem(placement: .topBarTrailing, content: {
                Picker("", selection: $selectedView) {
                    ForEach(SelectView.allCases) { view in
                        Text(view.description)
                            .tag(view)
                    }
                }
            })
            ToolbarItem(placement: .topBarTrailing, content: {
                Button(action: {
                    self.addNewDay.toggle()
                }, label: {
                    Image(systemName: "plus")
                        .padding()
                })
            })
        }
        .overlay {
            if selectedView == .list {
                if let array = month.days {
                    if array.isEmpty {
                        VStack {
                            Image(systemName: "list.bullet.clipboard")
                                .padding()
                                .font(.system(size: 55, weight: .bold, design: .rounded))
                            Text("The list is empty")
                                .padding()
                                .font(.system(size: 25, weight: .bold, design: .rounded))
                        }
                    }
                }
            }
        }
        .navigationTitle(month.title ?? "no title")
        .sheet(isPresented: $addNewDay, content: {
            AddDayView(vm: vm, dissmiss: $addNewDay, month: month)
        })
    }
}




