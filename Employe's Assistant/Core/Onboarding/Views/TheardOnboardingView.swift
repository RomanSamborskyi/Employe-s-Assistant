//
//  TheardOnboardingView.swift
//  Employee's Assistant
//
//  Created by Roman Samborskyi on 25.03.2024.
//

import SwiftUI

struct TheardOnboardingView: View {
    
    @Binding var pageNumber: OnboardingPages
    @Binding var hideOnboarding: Bool
    
    var body: some View {
        ZStack {
            Color.purple
            
            Button(action: {
                self.hideOnboarding = false
            }, label: {
                HStack {
                    Image(systemName: "arrow.right")
                        .fontWeight(.bold)
                }
                .padding()
                .foregroundStyle(Color.purple)
                .background(Color.white)
                .clipShape(Circle())
            })
        }.ignoresSafeArea(.all, edges: .all)
    }
}
