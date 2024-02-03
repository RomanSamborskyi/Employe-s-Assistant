//
//  CslendarView.swift
//  Employee's Assistant
//
//  Created by Roman Samborskyi on 03.02.2024.
//

import SwiftUI

struct CalendarView: View {
    
    @State private var days: [String] = ["Mon", "Tue", "Wed", "Thu", "Fri", "Sat", "Sun"]
    @State private var columns: [GridItem] = Array(repeating: GridItem(.flexible()), count: 7)
    @State private var sheetIsPresented: Bool = false
    @State private var showConfirmationDialog: Bool = false
    @AppStorage("isDark") var isDark: Bool = false
    @ObservedObject var vm: MonthsViewModel
    let month: MonthEntity
    
    var body: some View {
        VStack {
            HStack {
                ForEach(days, id: \.self) { day in
                    Text(day)
                        .padding(8)
                        .font(.system(size: 18, weight: .bold, design: .rounded))
                }
            }
            LazyVGrid(columns: columns, spacing: 30) {
                ForEach(vm.fetchDates(month)) { day in
                    if day.day == -1 {
                        Text("")
                    } else {
                        Text("\(day.day)")
                            .background(vm.checkDays(day, month) ? RoundedRectangle(cornerRadius: 10)
                                .frame(width: 35,height: 35)
                                .foregroundStyle(Color.accentColor.opacity(0.3)) : nil )
                            .onTapGesture {
                                if vm.checkDays(day, month) {
                                    vm.getCurrentDay(day, month)
                                    sheetIsPresented.toggle()
                                }
                            }
                            .onLongPressGesture {
                                if vm.checkDays(day, month) {
                                    vm.getCurrentDay(day, month)
                                    showConfirmationDialog.toggle()
                                }
                            }
                    }
                }
            }.padding()
            
            HStack {
                Text("Monthly progress")
                    .font(.system(size: 25, weight: .bold, design: .rounded))
                Image(systemName: "figure.step.training")
                    .font(.system(size: 25, weight: .bold, design: .rounded))
                    .foregroundStyle(Color.accentColor)
            } .padding()
            ProgresBarView(vm: vm, month: month)
            Spacer()
        }.sheet(isPresented: $sheetIsPresented) {
            MoreDetailsOfDayView(day: vm.currentDay!)
                .accentColor(vm.settings.newAccentColor)
                .preferredColorScheme(isDark ? .dark : .light)
        }
        .confirmationDialog("", isPresented: $showConfirmationDialog, actions: {
            Button(role: .destructive, action: { vm.deleteDay(month: month, day: vm.currentDay!)
            },label: {
                HStack {
                    Text("Delete")
                    Spacer()
                    Image(systemName: "trash")
                }
            })
        })
    }
}

#Preview {
    CalendarView(vm: MonthsViewModel(), month: MonthEntity(context: MonthsViewModel().coreData.context))
}
