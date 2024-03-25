//
//  FirstOnboardingView.swift
//  Employee's Assistant
//
//  Created by Roman Samborskyi on 25.03.2024.
//

import SwiftUI

struct FirstOnboardingView: View {
    
    @Binding var pageNumber: OnboardingPages
    
    var body: some View {
        ZStack {
            Color.red
            
            Button(action: {
                self.pageNumber = .second
            }, label: {
                HStack {
                    Image(systemName: "arrow.right")
                        .fontWeight(.bold)
                }
                .padding()
                .foregroundStyle(Color.red)
                .background(Color.white)
                .clipShape(Circle())
            })
        }.ignoresSafeArea(.all, edges: .all)
    }
}
