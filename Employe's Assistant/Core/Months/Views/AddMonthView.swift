//
//  AddMonthView.swift
//  Employe's Assistant
//
//  Created by Roman Samborskyi on 01.12.2023.
//

import SwiftUI

struct AddMonthView: View {
    
    @AppStorage("isDark") var isDark: Bool = false
    @State private var targetText: String = ""
    @State private var selectedMonth: Monthes = .empty
    @StateObject var vm: MonthsViewModel
    @Binding var dissmiss: Bool
    
    var body: some View {
        VStack {
            Image(systemName: "calendar.badge.plus")
                .font(.system(size: 65, weight: .bold, design: .rounded))
                .foregroundStyle(Color.accentColor)
            Text("Add new month:")
                .font(.system(size: 35, weight: .bold, design: .rounded))
            HStack {
                Text("Select a month:")
                    .padding(10)
                    .font(.system(size: 25, weight: .bold, design: .rounded))
                Spacer()
                Picker("", selection: $selectedMonth, content: {
                    ForEach(Monthes.allCases) { month in
                        Text(month.description)
                    }
                }).pickerStyle(.automatic)
            }.padding()
            HStack {
                Text("Set a hours target fo the month: ")
                    .padding(10)
                    .font(.system(size: 20, weight: .bold, design: .rounded))
                Spacer()
                TextField("Type...", text: $targetText)
                    .padding(10)
                    .frame(width: 100)
                    .background(Color.gray.opacity(0.3))
                    .clipShape(RoundedRectangle(cornerRadius: 15))
            }.padding()
            
            Button(action: {
                vm.addNewMonth(title: selectedMonth.description, monthTarget: Int32(targetText) ?? 0)
                HapticEngineManager.instance.hapticNotification(with: .success)
                self.dissmiss = false
            }, label: {
                Text("SAVE")
                    .padding()
                    .foregroundStyle(Color.white)
                    .frame(maxWidth: .infinity)
                    .background(Color.accentColor)
                    .clipShape(RoundedRectangle(cornerRadius: 15))
            }).padding()
        }.accentColor(vm.newAccentColor)
            .preferredColorScheme(isDark ? .dark : .light)
    }
}

#Preview {
    AddMonthView(vm: MonthsViewModel(), dissmiss: .constant(false))
}
