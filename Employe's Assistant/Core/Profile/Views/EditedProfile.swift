//
//  EditedProfile.swift
//  Employe's Assistant
//
//  Created by Roman Samborskyi on 16.12.2023.
//

import SwiftUI

struct EditedProfile: View {
    
    @State private var name: String = ""
    @State private var company: String = ""
    @State private var position: String = ""
    @State private var hourSalary: Double = 0
    
    var body: some View {
        VStack(alignment: .leading) {
            Text("Enter your name:")
                .padding(5)
                .font(.system(size: 20, weight: .regular, design: .rounded))
            TextField("Your name...", text: $name)
                .padding()
                .background(
                    Color.gray.opacity(0.5)
                        .clipShape(RoundedRectangle(cornerRadius: 15))
                )
            Text("Enter your company name:")
                .padding(5)
                .font(.system(size: 20, weight: .regular, design: .rounded))
            TextField("Company...", text: $name)
                .padding()
                .background(
                    Color.gray.opacity(0.5)
                        .clipShape(RoundedRectangle(cornerRadius: 15))
                )
            Text("Enter your position:")
                .padding(5)
                .font(.system(size: 20, weight: .regular, design: .rounded))
            TextField("Position...", text: $name)
                .padding()
                .background(
                    Color.gray.opacity(0.5)
                        .clipShape(RoundedRectangle(cornerRadius: 15))
                )
            Text("Enter your hour salary to let us calculate for you your total salary per month")
                .padding(5)
                .font(.system(size: 20, weight: .regular, design: .rounded))
            TextField("0..", text: $name)
                .padding()
                .background(
                    Color.gray.opacity(0.5)
                        .clipShape(RoundedRectangle(cornerRadius: 15))
                )
            
            Button(action: {
                
            } , label: {
                Label(
                    title: { Text("SAVE") }, icon: { Image(systemName: "square.and.arrow.down.fill") }
                ).padding()
                    .foregroundStyle(Color.white)
                .background(
                    Color.accentColor
                        .clipShape(RoundedRectangle(cornerRadius: 15))
                )
                .frame(maxWidth: .infinity)
            })
        } .navigationTitle("Profile")
            .padding()
    }
}

#Preview {
    EditedProfile()
}
