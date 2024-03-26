//
//  FifthOnboardingView.swift
//  Employee's Assistant
//
//  Created by Roman Samborskyi on 26.03.2024.
//

import SwiftUI

struct FourthOnboardingView: View {
    
    @Binding var targetText: String
    @Binding var hourSalary: String
    @Binding var selectedMonth: Monthes
    
    var body: some View {
        ZStack {
            Color.white
            VStack {
                Spacer()
                Image(systemName: "gear.badge")
                    .font(.system(size: 65, weight: .bold, design: .rounded))
                    .foregroundStyle(Color.accentColor)
                Text("Let's make some basic setup")
                    .font(.system(size: 35, weight: .bold, design: .rounded))
                    .multilineTextAlignment(.center)
                HStack {
                    Text("Add new month:")
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
                        .keyboardType(.numberPad)
                }.padding()
                HStack {
                    Text("Set your hour salary:")
                        .padding(10)
                        .font(.system(size: 20, weight: .bold, design: .rounded))
                        .multilineTextAlignment(.center)
                    Spacer()
                    TextField("Type...", text: $hourSalary)
                        .padding(10)
                        .frame(width: 100)
                        .background(Color.gray.opacity(0.3))
                        .clipShape(RoundedRectangle(cornerRadius: 15))
                        .keyboardType(.numberPad)
                }.padding()
                Spacer()
            }.ignoresSafeArea(.all, edges: .all)
        }
    }
}

