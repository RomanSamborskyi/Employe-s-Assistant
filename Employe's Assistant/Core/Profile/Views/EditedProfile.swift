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
    @State private var hourSalary: String = ""
    @ObservedObject var vm: ProfileViewModel
    
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
            TextField("Company...", text: $company)
                .padding()
                .background(
                    Color.gray.opacity(0.5)
                        .clipShape(RoundedRectangle(cornerRadius: 15))
                )
            Text("Enter your position:")
                .padding(5)
                .font(.system(size: 20, weight: .regular, design: .rounded))
            TextField("Position...", text: $position)
                .padding()
                .background(
                    Color.gray.opacity(0.5)
                        .clipShape(RoundedRectangle(cornerRadius: 15))
                )
            Text("Enter your hour salary to let us calculate for you your total salary per month")
                .padding(5)
                .font(.system(size: 20, weight: .regular, design: .rounded))
            TextField("0..", text: $hourSalary)
                .padding()
                .background(
                    Color.gray.opacity(0.5)
                        .clipShape(RoundedRectangle(cornerRadius: 15))
                )
            
            Button(action: {
                vm.profile.edite()
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
            .onAppear {
                withAnimation(Animation.bouncy) {
                    self.name = vm.profile.name
                    self.position = vm.profile.position
                    self.company = vm.profile.company
                    self.hourSalary = String(vm.profile.hourSalary)
                }
            }
    }
}

#Preview {
    EditedProfile(vm: ProfileViewModel())
}
