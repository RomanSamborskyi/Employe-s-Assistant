//
//  MonthsMainView.swift
//  Employe's Assistant
//
//  Created by Roman Samborskyi on 01.12.2023.
//

import SwiftUI

struct MonthsMainView: View {
    
    @StateObject private var viewModel: MonthsViewModel = MonthsViewModel()
    
    var body: some View {
         NavigationView {
             List {
                
             }.navigationTitle("Months")
        }
    }
}

#Preview {
    MonthsMainView()
}
