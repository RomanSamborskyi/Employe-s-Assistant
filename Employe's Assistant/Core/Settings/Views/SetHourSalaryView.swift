//
//  SetHourSalaryView.swift
//  Employe's Assistant
//
//  Created by Roman Samborskyi on 22.12.2023.
//

import SwiftUI

struct SetHourSalaryView: View {
    @ObservedObject var vm: SettingsViewModel
    @Binding var setHours: Bool
    @Binding var hourSalary: Double
    @State private var text: String = ""
    var body: some View {
        VStack {
            Image(systemName: "dollarsign")
                .font(.system(size: 65, weight: .bold, design: .rounded))
                .foregroundStyle(Color.accentColor)
            Text("Set your hour salary:")
                .font(.system(size: 35, weight: .bold, design: .rounded))
            TextField("", text: $text)
                .padding()
                .background(RoundedRectangle(cornerRadius: 15).foregroundStyle(Color.gray.opacity(0.4)))
                .padding()
                .keyboardType(.numberPad)
            Button(action: {
                withAnimation(Animation.bouncy) {
                    self.setHours.toggle()
                    self.hourSalary = (Double(text) ?? 0)
                    vm.saveHourSalary(Double(text) ?? 0)
                }
            }, label: {
                Text("SAVE")
                    .padding()
                    .foregroundStyle(Color.white)
                    .frame(maxWidth: .infinity)
                    .background(Color.accentColor)
                    .clipShape(RoundedRectangle(cornerRadius: 15))
                    .padding()
                    
            })
        }.onAppear {
            self.text = String(vm.returnHourSalary())
        }
    }
}
