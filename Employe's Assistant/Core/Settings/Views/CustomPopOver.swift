//
//  CustomPopOver.swift
//  Employee's Assistant
//
//  Created by Roman Samborskyi on 27.01.2024.
//

import SwiftUI

struct CustomPopOver: View {

    @AppStorage("isDark") var isDark: Bool = false
    @Binding var trigerPopOver: Bool
    let text: String
    let extraText: String?
    let iconName: String
    
    var body: some View {
        VStack(alignment: .center) {
            HStack {
                Image(systemName: iconName)
                    .font(.title)
                    .foregroundStyle(Color.newAccentColor)
                VStack(alignment: .leading) {
                    Text(text)
                    if extraText != nil {
                        Text(extraText!)
                            .font(.callout)
                            .foregroundStyle(Color.gray)
                    }
                }
            }.padding()
                .background(
                    ZStack {
                        RoundedRectangle(cornerRadius: 15)
                            .foregroundStyle(isDark ? .black : .white)
                            //.frame(width: 330, height: 75)
                        RoundedRectangle(cornerRadius: 15)
                            .stroke(lineWidth: 3)
                            .foregroundStyle(Color.newAccentColor)
                            //.frame(width: 330, height: 75)
                    }
                )
            Spacer()
        }.onAppear {
            DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
                withAnimation(Animation.bouncy) {
                    self.trigerPopOver = false
                }
            }
        }
    }
}
