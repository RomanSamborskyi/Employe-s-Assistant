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
        VStack{
            HStack {
                Image(systemName: "person.fill")
                    .font(.title)
                VStack(alignment: .leading) {
                    Text("name")
                        .foregroundStyle(Color.gray)
                        .font(.caption2)
                    Text(profile.name)
                        .font(.system(size: 25, weight: .regular, design: .rounded))
                }.padding(5)
                Spacer()
            }
            HStack {
                Image(systemName: "house.fill")
                    .font(.title)
                VStack(alignment: .leading) {
                    Text("company")
                        .foregroundStyle(Color.gray)
                        .font(.caption2)
                    Text(profile.company)
                        .font(.system(size: 25, weight: .regular, design: .rounded))
                }.padding(5)
                Spacer()
            }
            HStack {
                Image(systemName: "figure.wave.circle")
                    .font(.title)
                VStack(alignment: .leading) {
                    Text("position")
                        .foregroundStyle(Color.gray)
                        .font(.caption2)
                    Text(profile.position)
                        .font(.system(size: 25, weight: .regular, design: .rounded))
                }.padding(5)
                Spacer()
            }
            HStack {
                Image(systemName: "dollarsign.circle")
                    .font(.title)
                VStack(alignment: .leading) {
                    Text("hour salary")
                        .foregroundStyle(Color.gray)
                        .font(.caption2)
                    Text(String(format: "%.2f", profile.hourSalary))
                        .font(.system(size: 25, weight: .regular, design: .rounded))
                }.padding(5)
                Spacer()
            }
            Spacer()
        }.padding()
    }
}

#Preview {
    ProfileView(profile: Profile(name: "Roman", company: "Makro", position: "Picker", hourSalary: 160, isEdited: false))
}
