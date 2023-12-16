//
//  ProfileViewModel.swift
//  Employe's Assistant
//
//  Created by Roman Samborskyi on 16.12.2023.
//

import Foundation



class ProfileViewModel: ObservableObject {
    
    @Published var profile: Profile = Profile(name: "Roman", company: "Makro", position: "Picker", hourSalary: 160, isEdited: false)
}
