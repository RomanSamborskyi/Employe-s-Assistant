//
//  ProfileViewModel.swift
//  Employe's Assistant
//
//  Created by Roman Samborskyi on 16.12.2023.
//

import Foundation
import CoreData


class ProfileViewModel: ObservableObject {
    
    @Published var profile: Profile = Profile(name: "Roman", company: "Makro", position: "Picker", hourSalary: 160, isEdited: false)
    @Published var profile2: [ProfileEntity] = []
    let coreData = CoreDataManager.instanse
    
    
    init() {
        
    }
    
    func getProfileInfo() {
        let request = NSFetchRequest<ProfileEntity>(entityName: coreData.profileEntety)
        do {
            profile2 = try coreData.context.fetch(request)
        } catch let error {
            print("Error of fetching profile info: \(error.localizedDescription)")
        }
    }
    
    
}
