//
//  MonthsViewModel.swift
//  Employe's Assistant
//
//  Created by Roman Samborskyi on 01.12.2023.
//

import Foundation
import CoreData


class MonthsViewModel: ObservableObject {
    
    let coreData: CoreDataManager = CoreDataManager.instanse
    
    @Published var months: [MontEntity] = []
    
    init() { }
    
    func save() {
        coreData.save()
    }
}
