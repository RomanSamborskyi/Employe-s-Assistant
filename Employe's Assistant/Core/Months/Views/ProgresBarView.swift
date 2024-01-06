//
//  ProgresBarView.swift
//  Employe's Assistant
//
//  Created by Roman Samborskyi on 28.12.2023.
//

import SwiftUI

struct ProgresBarView: View {
    
    @ObservedObject var vm: MonthsViewModel
    let month: MonthEntity
    @State private var width: CGFloat = 0
    
    var body: some View {
        HStack {
            ZStack(alignment: .leading) {
                RoundedRectangle(cornerRadius: 25)
                    .frame(width: 180, height: 20)
                    .foregroundStyle(Color.gray)
                RoundedRectangle(cornerRadius: 25)
                    .frame(width: width, height: 20)
                    .foregroundStyle(Int32(vm.countHours(for: month)) >= month.monthTarget ? Color.green.gradient : Color.accentColor.gradient)
            }
            Text(vm.countHoursTitle(for: month))
                .foregroundStyle(Color.primary)
                .font(.system(size: 20, weight: .bold, design: .rounded))
               
            Text("/")
                .foregroundStyle(Color.primary)
                .font(.system(size: 25, weight: .bold, design: .rounded))
            Text("\(month.monthTarget)")
                .foregroundStyle(Color.gray)
                .font(.system(size: 15, weight: .medium, design: .rounded))
                
        }
            .onAppear {
                withAnimation(Animation.bouncy) {
                    width = vm.progressBar(for: month, width: 180)
                }
            }
    }
}

#Preview {
    ProgresBarView(vm: MonthsViewModel(), month: MonthEntity(context: CoreDataManager.instanse.context))
}