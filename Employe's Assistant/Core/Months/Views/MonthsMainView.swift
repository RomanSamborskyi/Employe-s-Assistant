//
//  MonthsMainView.swift
//  Employe's Assistant
//
//  Created by Roman Samborskyi on 01.12.2023.
//

import SwiftUI

struct MonthsMainView: View {
    
    @StateObject private var viewModel: MonthsViewModel = MonthsViewModel()
    @State private var addNewMonth: Bool = false
    
    var body: some View {
        NavigationStack {
            List {
                ForEach(viewModel.months) { month in
                   NavigationLink(month.title ?? "NO TITLE", destination: { DayDetailView(vm: viewModel, month: month) })
                }.onDelete(perform: { indexSet in
                    viewModel.deleteMonth(indexSet: indexSet)
                })
            }.navigationTitle("Months")
                .toolbar {
                    ToolbarItem(placement: .topBarTrailing, content: {
                        Button(action: {
                            withAnimation(Animation.spring) {
                                self.addNewMonth.toggle()
                            }
                        }, label: {
                            Image(systemName: "plus")
                                .padding()
                        })
                    })
                }
                .sheet(isPresented: $addNewMonth) {
                    AddMonthView(vm: viewModel, dissmiss: $addNewMonth)
            }
        }
    }
}

#Preview {
    MonthsMainView()
}
