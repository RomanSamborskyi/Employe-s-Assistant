//
//  OnboardingMainView.swift
//  Employee's Assistant
//
//  Created by Roman Samborskyi on 25.03.2024.
//

import SwiftUI

struct OnboardingMainView: View {
    var body: some View {
        TabView {
            FirstOnboardingView()
                .tag(1)
            SecondOnboardingView()
                .tag(2)
            TheardOnboardingView()
                .tag(3)
        }.tabViewStyle(.page)
            .ignoresSafeArea(.all, edges: .all)
    }
}

#Preview {
    OnboardingMainView()
}
