//
//  CslendarView.swift
//  Employee's Assistant
//
//  Created by Roman Samborskyi on 03.02.2024.
//

import SwiftUI
import WidgetKit


struct CalendarView: View {
    
    @State private var days: [String] = ["Mon", "Tue", "Wed", "Thu", "Fri", "Sat", "Sun"]
    @State private var columns: [GridItem] = Array(repeating: GridItem(.flexible()), count: 7)
    @State private var sheetIsPresented: Bool = false
    @State private var showConfirmationDialog: Bool = false
    @AppStorage("isDark") var isDark: Bool = false
    @ObservedObject var vm: MonthsViewModel
    let month: Month
    let dateFormatter: DateFormatter = {
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .short
        return dateFormatter
    }()
    
    var body: some View {
        ScrollView(.vertical, showsIndicators: false) {
            HStack {
                ForEach(days, id: \.self) { day in
                    Text(LocalizedStringKey(day))
                        .padding(Locale.preferredLanguages.first! == "uk-UA" ? 10 : 8)
                        .font(.system(size: 18, weight: .bold, design: .rounded))
                        .foregroundStyle(Color.newAccentColor).contrast(1.5)
                        .lineLimit(1)
                        .minimumScaleFactor(0.7)
                }
            }
            LazyVGrid(columns: columns, spacing: 30) {
                ForEach(vm.fetchDates(month)) { day in
                    if day.day == -1 {
                        Text("")
                    } else {
                        Text("\(day.day)")
                            .foregroundStyle(dateFormatter.string(from: day.date) == dateFormatter.string(from: Date()) ? Color.newAccentColor : Color.primary)
                            .fontWeight(dateFormatter.string(from: day.date) == dateFormatter.string(from: Date()) ? .bold : nil)
                            .background(vm.checkDays(day, month) ? RoundedRectangle(cornerRadius: 10)
                                .frame(width: 35,height: 35)
                                .foregroundStyle(Color.newAccentColor.opacity(0.5)) : nil )
                            .overlay {
                                if dateFormatter.string(from: day.date) == dateFormatter.string(from: Date()) {
                                    RoundedRectangle(cornerRadius: 10)
                                        .stroke(lineWidth: 3)
                                        .foregroundStyle(Color.newAccentColor)
                                        .frame(width: 35, height: 35)
                                }
                            }
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
            }
            .padding()
            
            HStack {
                Text("Monthly progress")
                    .font(.system(size: 25, weight: .bold, design: .rounded))
                Image(systemName: "figure.step.training")
                    .font(.system(size: 25, weight: .bold, design: .rounded))
                    .foregroundStyle(Color.newAccentColor)
            } 
            .padding()
            
            ProgresBarView(vm: vm, month: month)
            
            Spacer()
            
        }
        .sheet(isPresented: $sheetIsPresented) {
            MoreDetailsOfDayView(day: vm.currentDay!)
                .accentColor(Color.newAccentColor)
                .preferredColorScheme(isDark ? .dark : .light)
        }
        .confirmationDialog("", isPresented: $showConfirmationDialog, actions: {
            Button(role: .destructive, action: { 
                vm.deleteDay(month: month, day: vm.currentDay!)
                WidgetCenter.shared.reloadAllTimelines()
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
