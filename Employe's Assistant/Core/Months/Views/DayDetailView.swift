//
//  DayDetailView.swift
//  Employe's Assistant
//
//  Created by Roman Samborskyi on 01.12.2023.
//

import SwiftUI

struct DayDetailView: View {
    
    var dateFormater: DateFormatter = {
       let dateFormater = DateFormatter()
        dateFormater.dateStyle = .medium
        return dateFormater
    }()
    @ObservedObject var vm: MonthsViewModel
    @State private var addNewDay: Bool = false
    let month: MonthEntity
    var body: some View {
        List {
            ForEach(vm.fetchDays(from: month)) { day in
              NavigationLink(destination: { MoreDetailsOfDayView(day: day) }, label: {
                  HStack {
                  Text(dateFormater.string(from: day.date ?? Date()))
                  Spacer()
                  Text("\(day.hours):\(day.minutes)")
              }
              }).contextMenu {
                  Button(role: .destructive, action: { vm.deleteDay(month: month, day: day)
                  },label: {
                      HStack {
                          Text("Delete")
                          Spacer()
                          Image(systemName: "trash")
                      }
                  })
              }
            }
        }.toolbar {
            ToolbarItem(placement: .topBarTrailing, content: {
                Button(action: {
                    self.addNewDay.toggle()
                }, label: {
                    Image(systemName: "plus")
                        .padding()
                })
            })
        }
        .navigationTitle(month.title ?? "no title")
        .sheet(isPresented: $addNewDay, content: {
            AddDayView(vm: vm, dissmiss: $addNewDay, month: month)
        })
    }
}

#Preview {
    DayDetailView(vm: MonthsViewModel(), month: MonthEntity(context: MonthsViewModel().coreData.context))
}
