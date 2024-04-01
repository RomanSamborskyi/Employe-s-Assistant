//
//  SecondOnboardingView.swift
//  Employee's Assistant
//
//  Created by Roman Samborskyi on 25.03.2024.
//

import SwiftUI

struct SecondOnboardingView: View {
  
    var body: some View {
        ZStack {
            Color.white
            VStack{
                Image("2")
                    .resizable()
                    .frame(width: 210, height: 380)
                Text("Add working days...".uppercased())
                    .padding(10)
                    .font(.system(size: 25, weight: .bold, design: .rounded))
                    .multilineTextAlignment(.center)
                Text("And select the time of the start of work, the time of lunch, the time of the end of the working day and the date.")
                    .padding(10)
                    .font(.system(size: 15, weight: .regular, design: .rounded))
                    .multilineTextAlignment(.center)
            }.padding()
        }.ignoresSafeArea(.all, edges: .all)
    }
}

