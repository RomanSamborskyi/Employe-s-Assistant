//
//  ProfileMainView.swift
//  Employe's Assistant
//
//  Created by Roman Samborskyi on 01.12.2023.
//

import SwiftUI

struct ProfileMainView: View {
    
    @StateObject var vm: ProfileViewModel = ProfileViewModel()

    var body: some View {
        NavigationView {
            VStack {
                if vm.profile != nil {
                    switch vm.profile.isEdited {
                    case true:
                        EditedProfile(vm: vm )
                    case false:
                        ProfileView(profile: vm.profile)
                    }
                } else {
                    EditedProfile(vm: vm )
                }
                
            }.navigationTitle("Profile")
                .toolbar {
                    ToolbarItem(placement: .topBarTrailing) {
                        Button(action: {
                            vm.profile.edite()
                        }, label: {
                            Text("Edite")
                        })
                }
            }
       }
    }
}

