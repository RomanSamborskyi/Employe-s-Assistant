//
//  OnboardingMainView.swift
//  Employee's Assistant
//
//  Created by Roman Samborskyi on 25.03.2024.
//

import SwiftUI



struct OnboardingMainView: View {
    
    @State var viewNumber: OnboardingPages = .first
    @Binding var hideOnboarding: Bool
   
    var body: some View {
            switch viewNumber {
            case .first:
                FirstOnboardingView(pageNumber: $viewNumber)
            case .second:
                SecondOnboardingView(pageNumber: $viewNumber)
            case .thread:
                TheardOnboardingView(pageNumber: $viewNumber, hideOnboarding: $hideOnboarding)
        }
    }
}

