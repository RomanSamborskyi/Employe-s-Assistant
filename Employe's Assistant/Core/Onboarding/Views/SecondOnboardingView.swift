//
//  SecondOnboardingView.swift
//  Employee's Assistant
//
//  Created by Roman Samborskyi on 25.03.2024.
//

import SwiftUI

struct SecondOnboardingView: View {
    
    @Binding var pageNumber: OnboardingPages
    
    var body: some View {
        ZStack {
            Color.green
            
            Button(action: {
                self.pageNumber = .thread
            }, label: {
                HStack {
                    Image(systemName: "arrow.right")
                        .fontWeight(.bold)
                }
                .padding()
                .foregroundStyle(Color.green)
                .background(Color.white)
                .clipShape(Circle())
            })
        }.ignoresSafeArea(.all, edges: .all)
    }
}

