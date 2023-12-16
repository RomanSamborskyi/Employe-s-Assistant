//
//  ProfileMainView.swift
//  Employe's Assistant
//
//  Created by Roman Samborskyi on 01.12.2023.
//

import SwiftUI

struct ProfileMainView: View {
    
    var profile: Profile = Profile(name: "Roman", company: "Makro", position: "Picker", hourSalary: 160, isEdited: false)
    
    var body: some View {
        NavigationView {
            VStack {
                switch profile.isEdited {
                case true:
                   EditedProfile()
                case false:
                   ProfileView()
                }
            }.navigationTitle("Profile")
                .toolbar {
                    ToolbarItem(placement: .topBarTrailing) {
                        Button(action: {
                            
                        }, label: {
                            Text("Edite")
                        })
                }
            }
       }
    }
}

#Preview {
    ProfileMainView()
}
