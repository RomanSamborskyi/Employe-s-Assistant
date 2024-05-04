//
//  ProgresBarView.swift
//  Employe's Assistant
//
//  Created by Roman Samborskyi on 28.12.2023.
//

import SwiftUI

struct ProgresBarView: View {
    
    @ObservedObject var vm: MonthsViewModel
    let month: Month
    @State private var width: CGFloat = 0
    
    var body: some View {
        HStack {
            ZStack(alignment: .leading) {
                RoundedRectangle(cornerRadius: 25)
                    .frame(width: 180, height: 20)
                    .foregroundStyle(Color.gray)
                RoundedRectangle(cornerRadius: 25)
                    .frame(width: width, height: 20)
                    .foregroundStyle(Int32(vm.countHours(for: month) ?? 0) >= month.monthTarget ?? 0 ? Color.green.gradient : Color.newAccentColor.gradient)
            }
            Text(vm.countHoursTitle(for: month) ?? "")
                .foregroundStyle(Color.primary)
                .font(.system(size: 20, weight: .bold, design: .rounded))
                .lineLimit(1)
                .minimumScaleFactor(0.8)
            Text("/")
                .foregroundStyle(Color.primary)
                .font(.system(size: 25, weight: .bold, design: .rounded))
            Text("\(month.monthTarget ?? 0)")
                .foregroundStyle(Color.gray)
                .font(.system(size: 15, weight: .medium, design: .rounded))
        }
        .onAppear {
            withAnimation(Animation.bouncy) {
                self.width = vm.progressBar(for: month, width: 180)
            }
        }
        .onChange(of: vm.months.first(where: { $0.title == month.title })?.days!) { _ in
            withAnimation(Animation.bouncy) {
                self.width = vm.progressBar(for: month, width: 180)
            }
        }
    }
}
