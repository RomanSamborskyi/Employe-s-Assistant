//
//  UIPractice.swift
//  ConcurrencyPractice
//
//  Created by Roman Samborskyi on 08.06.2024.
//

import SwiftUI



struct SignInView: View {
    
    @AppStorage("isDark") var isDark: Bool = false
    @State private var login: String = ""
    @State private var password: String = ""
    
    var body: some View {
        GeometryReader { proxy in
            ScrollView {
                ZStack {
                    isDark ? Color.newAccentColor.darker(per: 20) : Color.white
                    BackgroundImage(isDark: $isDark)
                        .offset(y: -proxy.size.height * 0.34)
                    VStack {
                        
                        TextFiledsSection(isDark: $isDark, login: $login, password: $password)
                        
                        ButtonsSection(isDark: $isDark)
                        
                    }
                    .padding(.top, proxy.size.height / 7.6)
                }
                .ignoresSafeArea()
            }
            .background(isDark ? Color.newAccentColor.darker(per: 20) : Color.white)
            .scrollIndicators(ScrollIndicatorVisibility.hidden)
        }
    }
}

#Preview {
    SignInView()
}

struct BackgroundShape: Shape {
    func path(in rect: CGRect) -> Path {
        Path { path in
            
            path.move(to: CGPoint(x: rect.minX, y: rect.midY))
            
            
            
            path.addQuadCurve(to: CGPoint(x: rect.maxX, y: rect.midY), control: CGPoint(x: rect.width * 0.85, y: rect.height * 0.35))
            
            path.addLine(to: CGPoint(x: rect.maxX, y: rect.maxY))
            path.addLine(to: CGPoint(x: rect.minX , y: rect.maxY))
            path.addLine(to: CGPoint(x: rect.minX, y: rect.minY))
        }
    }
}

struct BackgroundShapeStroke: Shape {
    func path(in rect: CGRect) -> Path {
        Path { path in
            
            path.move(to: CGPoint(x: rect.minX, y: rect.midY))
            
            
            
            path.addQuadCurve(to: CGPoint(x: rect.maxX, y: rect.midY), control: CGPoint(x: rect.width * 0.85, y: rect.height * 0.35))
        }
    }
}

struct BackgroundImage: View {
    
    @Binding var isDark: Bool
    
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 5)
                .foregroundStyle(isDark ? Color.black : Color.newAccentColor.opacity(0.5))
            BackgroundShapeStroke()
                .stroke(style: StrokeStyle(lineWidth: 7, lineCap: .round, lineJoin: .round, miterLimit: 3, dash: [1], dashPhase: 0))
                .foregroundStyle(Color.newAccentColor)
            BackgroundShape()
                .fill(isDark ? Color.newAccentColor.darker(per: 20) : Color.white)
        }
        .frame(maxWidth: .infinity)
        .frame(maxHeight: .infinity)
    }
}

struct TextFiledsSection: View {
    
    @Binding var isDark: Bool
    @Binding var login: String
    @Binding var password: String
    @State private var showPassword: Bool = false
    var body: some View {
        VStack(alignment: .leading) {
            Text("Email Adress")
                .font(.callout)
                .fontWeight(.bold)
                .padding(.leading, 5)
            TextField("Enter your email", text: $login)
                .padding()
                .background(RoundedRectangle(cornerRadius: 15)
                    .foregroundStyle(isDark ? Color.newAccentColor.darker(per: 50) : Color.gray.opacity(0.2))
                )
            Text("Password")
                .font(.callout)
                .fontWeight(.bold)
                .padding(.leading, 5)
            ZStack(alignment: .trailing) {
                if showPassword {
                    TextField("Enter your password", text: $password)
                        .padding()
                        .background(RoundedRectangle(cornerRadius: 15)
                            .foregroundStyle(isDark ? Color.newAccentColor.darker(per: 50) : Color.gray.opacity(0.2))
                        )
                } else {
                    SecureField("Enter your password", text: $password)
                        .padding()
                        .background(RoundedRectangle(cornerRadius: 15)
                            .foregroundStyle(isDark ? Color.newAccentColor.darker(per: 50) : Color.gray.opacity(0.2))
                        )
                }
                Button(action: {
                    self.showPassword.toggle()
                }, label: {
                    Image(systemName: showPassword ? "eye.fill" : "eye.slash.fill")
                        .foregroundStyle(isDark ? Color.newAccentColor.darker(per: 60) : Color.gray.opacity(0.7))
                })
                .padding()
            }
            Button(action: {
                
            }, label: {
                Text("Forgot Password?")
                    .foregroundStyle(Color.primary)
                    .fontWeight(.bold)
            })
            .offset(x: 212)
        }
        .padding(.horizontal)
        .padding(.vertical, 5)
    }
}

struct ButtonsSection: View {
    
    @Binding var isDark: Bool
    
    @ViewBuilder
    func makeButton(label: String, image: Image?, color: Color, fontColor: Color) -> some View {
        Button(action: {
            
        }, label: {
            HStack {
                if let image = image {
                    image
                        .resizable()
                        .scaledToFit()
                        .frame(width: 20, height: 20)
                }
                Text(label)
            }
            .padding()
            .frame(maxWidth: .infinity)
            .foregroundStyle(fontColor)
            .background(
                RoundedRectangle(cornerRadius: 15)
                    .foregroundStyle(color)
            )
        })
        .padding(.horizontal)
        
    }
    
    var body: some View {
        VStack {
            makeButton(label: "Login", image: nil, color: isDark ? Color.newAccentColor.opacity(0.7) : Color.gray.opacity(0.2), fontColor: Color.white)
            HStack {
                RoundedRectangle(cornerRadius: 10)
                    .padding()
                    .frame(maxWidth: .infinity)
                    .frame(height: 35)
                Text("Or continue with")
                    .lineLimit(1)
                    .minimumScaleFactor(0.7)
                RoundedRectangle(cornerRadius: 10)
                    .padding()
                    .frame(maxWidth: .infinity)
                    .frame(height: 35)
            }
            .padding(.horizontal, 10)
        }
        makeButton(label: "Continue with Apple", image: Image(systemName: "apple.logo"), color: isDark ? Color.newAccentColor.darker(per: 50) : Color.gray.opacity(0.2), fontColor: Color.primary)
        makeButton(label: "Continue with Google", image: Image("google"), color: isDark ? Color.newAccentColor.darker(per: 50) : Color.gray.opacity(0.2), fontColor: Color.primary)
        Text("Don't have an account?")
            .padding(.top, 20)
        
        Button {
            
        } label: {
            Text("Sign Up")
                .padding(.bottom, 25)
                .font(.title2)
                .fontWeight(.bold)
                .foregroundStyle(isDark ? Color.yellow.opacity(0.7) : Color.newAccentColor.darker(per: 50))
        }

    }
}
