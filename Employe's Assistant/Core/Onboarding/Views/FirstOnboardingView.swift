//
//  FirstOnboardingView.swift
//  Employee's Assistant
//
//  Created by Roman Samborskyi on 25.03.2024.
//

import SwiftUI

struct FirstOnboardingView: View {
    
    var body: some View {
        ZStack {
            Color.white
            VStack {
                Image("1")
                    .resizable()
                    .frame(width: 210, height: 380)
                Text("Add month and start tracking your working time")
                    .padding(10)
                    .font(.system(size: 25, weight: .bold, design: .rounded))
                    .multilineTextAlignment(.center)
                Text("You can also specify the number of hours you plan to work per month")
                    .padding(10)
                    .font(.system(size: 15, weight: .regular, design: .rounded))
                    .multilineTextAlignment(.center)
            }.padding()
        }.ignoresSafeArea(.all, edges: .all)
    }
}

