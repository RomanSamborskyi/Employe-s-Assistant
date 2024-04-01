//
//  TheardOnboardingView.swift
//  Employee's Assistant
//
//  Created by Roman Samborskyi on 25.03.2024.
//

import SwiftUI

struct TheardOnboardingView: View {
    
    var body: some View {
        ZStack {
            Color.white
            VStack {
                Image("3")
                    .resizable()
                    .frame(width: 210, height: 380)
                Text("Statistic view".uppercased())
                    .padding(10)
                    .font(.system(size: 25, weight: .bold, design: .rounded))
                    .multilineTextAlignment(.center)
                Text("Visit the statistics screen to view statistics for the current month or history for previous months")
                    .padding(10)
                    .font(.system(size: 15, weight: .regular, design: .rounded))
                    .multilineTextAlignment(.center)
            }.padding()
        }.ignoresSafeArea(.all, edges: .all)
    }
}


