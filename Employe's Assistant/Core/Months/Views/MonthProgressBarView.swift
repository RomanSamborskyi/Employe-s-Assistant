//
//  MonthProgressBarView.swift
//  Employe's Assistant
//
//  Created by Roman Samborskyi on 02.12.2023.
//

import SwiftUI

struct MonthProgressBarView: View {
    
    @ObservedObject var vm: MonthsViewModel
    let month: Month
    @State private var width: CGFloat = 0
    
    var body: some View {
        ZStack(alignment: .leading) {
            RoundedRectangle(cornerRadius: 25)
                .frame(width: 100, height: 15)
                .foregroundStyle(Color.gray.opacity(0.5))
            RoundedRectangle(cornerRadius: 25)
                .frame(width: width, height: 15)
                .foregroundStyle(Int32(vm.countHours(for: month) ?? 0) >= month.monthTarget ?? 0 ? Color.green.gradient : Color.accentColor.gradient)
                
        }.onAppear {
            withAnimation(Animation.bouncy) {
                width = vm.progressBar(for: month, width: 100)
            }
        }
    }
}
