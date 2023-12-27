//
//  AddDayView.swift
//  Employe's Assistant
//
//  Created by Roman Samborskyi on 01.12.2023.
//

import SwiftUI

struct AddDayView: View {
    
    @AppStorage("isDark") var isDark: Bool = false
    @ObservedObject var vm: MonthsViewModel
    @State private var startHours: Hours = .zero
    @State private var startMinutes: Minutes = .zero
    @State private var endHours: Hours = .zero
    @State private var endMinutes: Minutes = .zero
    @State private var pauseTime: Pause = .zero
    @State private var date: Date = Date()
    @Binding var dissmiss: Bool
    let month: MonthEntity
    
    var body: some View {
        VStack {
            Image(systemName: "box.truck.badge.clock")
                .padding()
                .font(.system(size: 55, weight: .bold, design: .rounded))
                .foregroundStyle(Color.accentColor)
            Text("Set up working hours:")
                .font(.system(size: 30, weight: .bold, design: .rounded))
            HStack {
                Spacer()
                Text("hour")
                    .font(.caption2)
                    .frame(width: 40)
                Text("minute")
                    .font(.caption2)
                    .frame(width: 40)
            }.padding(10)
            HStack {
                Text("Start work at: ")
                    .padding(10)
                Spacer()
                Picker("", selection: $startHours, content: {
                    ForEach(Hours.allCases) { hour in
                        Text(hour.description)
                    }
                })
                Picker("", selection: $startMinutes, content: {
                    ForEach(Minutes.allCases) { minute in
                        Text(minute.description)
                    }
                })
            }
            HStack{
                Text("End work at: ")
                    .padding(10)
                Spacer()
                Picker("", selection: $endHours, content: {
                    ForEach(Hours.allCases) { hour in
                        Text(hour.description)
                    }
                })
                Picker("", selection: $endMinutes, content: {
                    ForEach(Minutes.allCases) { minute in
                        Text(minute.description)
                    }
                })
            }
            HStack{
                Text("Pause time: ")
                    .padding(10)
                Spacer()
                Picker("", selection: $pauseTime, content: {
                    ForEach(Pause.allCases) { minute in
                        Text(minute.description)
                    }
                })
            }
            HStack{
                Text("Date: ")
                    .padding(10)
                Spacer()
                DatePickerVIew(date: $date)
            }
            Button(action: {
                withAnimation(Animation.spring) {
                    self.dissmiss = false
                }
                vm.addHours(month: month, startHours: Int32(startHours.description) ?? 0, startMinutes: Int32(startMinutes.description) ?? 0, endHours: Int32(endHours.description) ?? 0, endMinutes: Int32(endMinutes.description) ?? 0, pauseTime: Int32(pauseTime.description) ?? 0, date: date)
            }, label: {
                Text("SAVE")
                    .padding()
                    .foregroundStyle(Color.white)
                    .frame(maxWidth: .infinity)
                    .background(Color.accentColor)
                    .clipShape(RoundedRectangle(cornerRadius: 15))
            }).padding()
        }.accentColor(vm.settings.newAccentColor)
            .preferredColorScheme(isDark ? .dark : .light)
    }
}

#Preview {
    AddDayView(vm: MonthsViewModel(), dissmiss: .constant(false), month: MonthEntity(context: CoreDataManager().context))
}
