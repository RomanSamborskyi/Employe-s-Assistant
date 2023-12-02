//
//  StatisticMainView.swift
//  Employe's Assistant
//
//  Created by Roman Samborskyi on 01.12.2023.
//

import SwiftUI

struct StatisticMainView: View {
    
    @StateObject var vm: StatisticViewModel = StatisticViewModel()
    
    var body: some View {
        NavigationView {
            List {
                MonthDetailView(vm: vm, month: vm.currentMonth!)
            }.navigationTitle("Statistic")
       }
    }
}

#Preview {
    StatisticMainView()
}
