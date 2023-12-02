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
    var dateFormater: DateFormatter = {
        var dateFormater: DateFormatter = DateFormatter()
        dateFormater.dateStyle = .medium
        return dateFormater
    }()
    var body: some View {
        NavigationStack {
            List {
                ForEach(viewModel.months) { month in
                    NavigationLink(destination: { DayDetailView(vm: viewModel, month: month) }, label: {
                        HStack {
                            Text(month.title ?? "no title")
                            Spacer()
                            MonthProgressBarView(vm: viewModel, month: month)
                        }
                    })
                }.onDelete(perform: { indexSet in
                    viewModel.deleteMonth(indexSet: indexSet)
                })
            }.navigationTitle(dateFormater.string(from: Date()))
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
                .overlay {
                    if viewModel.months.isEmpty {
                        VStack {
                            Image(systemName: "calendar.badge.exclamationmark")
                                .padding()
                                .font(.system(size: 55, weight: .bold, design: .rounded))
                            Text("There are no months added")
                                .padding()
                                .font(.system(size: 25, weight: .bold, design: .rounded))
                        }
                    }
                }
        }
    }
}

#Preview {
    MonthsMainView()
}
