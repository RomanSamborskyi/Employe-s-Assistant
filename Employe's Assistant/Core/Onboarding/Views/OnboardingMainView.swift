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
        VStack {
            switch viewNumber {
            case .first:
                FirstOnboardingView()
            case .second:
                SecondOnboardingView()
            case .thread:
                TheardOnboardingView()
            }
            HStack {
                ForEach(OnboardingPages.allCases, id: \.self) { page in
                    RoundedRectangle(cornerRadius: 15)
                        .frame(width: viewNumber == page ? 24 : 8, height: 8)
                        .onTapGesture {
                            withAnimation(Animation.bouncy) {
                                self.viewNumber = page
                            }
                        }
                }
                Spacer()
                Button(action: {
                    switch viewNumber {
                    case .first:
                        withAnimation(Animation.bouncy) {
                            self.viewNumber = .second
                        }
                    case .second:
                        withAnimation(Animation.bouncy) {
                            self.viewNumber = .thread
                        }
                    case .thread:
                        withAnimation(Animation.bouncy) {
                            self.hideOnboarding = false
                        }
                    }
                }, label: {
                    Image(systemName: viewNumber == .thread ? "checkmark" : "arrow.right")
                        .fontWeight(.bold)
                })
                .padding()
                .foregroundStyle(Color.white)
                .background(Color.blue)
                .clipShape(Circle())
            }.padding()
        }
    }
}

