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
    let month: MonthEntity
    
    var dateFormater: DateFormatter = {
       let dateFormater = DateFormatter()
        dateFormater.dateStyle = .medium
        return dateFormater
    }()
    
    var body: some View {
        List {
            if let array = month.day?.allObjects as? [DayEntity] {
                if !array.isEmpty {
                    Section {
                        ProgresBarView(vm: vm, month: month)
                    }
                }
            }
            ForEach(vm.fetchDays(from: month)) { day in
              NavigationLink(destination: { MoreDetailsOfDayView(day: day) }, label: {
                  HStack {
                  Text(dateFormater.string(from: day.date ?? Date()))
                  Spacer()
                  Text("\(day.hours):\(day.minutes)")
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

