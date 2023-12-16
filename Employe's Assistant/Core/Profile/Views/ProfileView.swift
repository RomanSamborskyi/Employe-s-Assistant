//
//  ProfileView.swift
//  Employe's Assistant
//
//  Created by Roman Samborskyi on 16.12.2023.
//

import SwiftUI

struct ProfileView: View {
    
    let profile: Profile
    
    var body: some View {
        HStack {
            VStack(alignment: .leading) {
                VStack(alignment: .leading) {
                    Text("name")
                        .foregroundStyle(Color.gray)
                    Text(profile.name)
                        .font(.system(size: 25, weight: .regular, design: .rounded))
                }.padding(5)
                VStack(alignment: .leading) {
                    Text("company")
                        .foregroundStyle(Color.gray)
                    Text(profile.company)
                        .font(.system(size: 25, weight: .regular, design: .rounded))
                }.padding(5)
                VStack(alignment: .leading) {
                    Text("position")
                        .foregroundStyle(Color.gray)
                    Text(profile.position)
                        .font(.system(size: 25, weight: .regular, design: .rounded))
                }
                VStack(alignment: .leading) {
                    Text("hour salary")
                        .foregroundStyle(Color.gray)
                    Text("\(profile.hourSalary)")
                        .font(.system(size: 25, weight: .regular, design: .rounded))
                }.padding(5)
            }
            Spacer()
        }
    }
}

#Preview {
    ProfileView(profile: Profile(name: "Roman", company: "Makro", position: "Picker", hourSalary: 160, isEdited: false))
}
