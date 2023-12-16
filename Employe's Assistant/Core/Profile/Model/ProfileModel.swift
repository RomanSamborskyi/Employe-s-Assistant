//
//  ProfileModel.swift
//  Employe's Assistant
//
//  Created by Roman Samborskyi on 16.12.2023.
//

import Foundation



struct Profile {
    var name: String
    var company: String
    var position: String
    var hourSalary: Double
    var isEdited: Bool
    
    mutating func edite() {
      isEdited = !isEdited
    }
}
