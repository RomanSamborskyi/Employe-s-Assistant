//
//  MonthProgressBarView.swift
//  Employe's Assistant
//
//  Created by Roman Samborskyi on 02.12.2023.
//

import SwiftUI

struct MonthProgressBarView: View {
    
    @ObservedObject var vm: MonthsViewModel
    let month: MonthEntity
    
    var body: some View {
        ZStack(alignment: .leading) {
            RoundedRectangle(cornerRadius: 25)
                .frame(width: 100, height: 15)
                .foregroundStyle(Color.gray.opacity(0.5))
            RoundedRectangle(cornerRadius: 25)
                .frame(width: vm.progressBar(for: month), height: 15)
                .foregroundStyle(Int32(vm.countHours(for: month)) >= month.monthTarget ? Color.green : Color.purple)
                
        }
    }
}

#Preview {
    MonthProgressBarView(vm: MonthsViewModel(), month: MonthEntity(context: CoreDataManager().context))
}
