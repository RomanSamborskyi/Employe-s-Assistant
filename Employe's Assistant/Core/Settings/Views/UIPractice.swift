//
//  UIPractice.swift
//  ConcurrencyPractice
//
//  Created by Roman Samborskyi on 08.06.2024.
//

import SwiftUI

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
    var body: some View {
        ZStack {
            Image("party")
                .resizable()
            BackgroundShapeStroke()
                .stroke(style: StrokeStyle(lineWidth: 7, lineCap: .round, lineJoin: .round, miterLimit: 3, dash: [1], dashPhase: 0))
                .foregroundStyle(Color.purpleStroke)
            BackgroundShape()
                .fill(Color.backgroundPurple)
        }
        .frame(maxWidth: .infinity)
        .frame(maxHeight: .infinity)
    }
}

struct CustomPicker: View {
    
    @Binding var tab: Selector
    
    var body: some View {
        HStack {
            ForEach(Selector.allCases, id: \.self) { tab in
                Text(tab.description)
                    .padding()
                    .frame(maxWidth: .infinity)
                    .frame(height: 40)
                    .foregroundStyle(self.tab == tab ? Color.white : Color.primary)
                    .background(self.tab == tab ? Color.loginButton : nil)
                    .clipShape(RoundedRectangle(cornerRadius: 10))
                    .onTapGesture {
                        withAnimation(Animation.bouncy) {
                            self.tab = tab
                        }
                    }
            }
        }
        .padding(4)
        .background(
            ZStack {
                RoundedRectangle(cornerRadius: 15)
                    .stroke(lineWidth: 2)
                    .foregroundStyle(Color.picker)
                RoundedRectangle(cornerRadius: 15)
                    .foregroundStyle(Color.textFieldPurple)
            }
        )
        .padding(.horizontal, 10)
    }
}

struct TextFiledsSection: View {
    
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
                    .foregroundStyle(Color.textFieldPurple)
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
                            .foregroundStyle(Color.textFieldPurple)
                        )
                } else {
                    SecureField("Enter your password", text: $password)
                        .padding()
                        .background(RoundedRectangle(cornerRadius: 15)
                            .foregroundStyle(Color.textFieldPurple)
                        )
                }
                Button(action: {
                    self.showPassword.toggle()
                }, label: {
                    Image(systemName: showPassword ? "eye.fill" : "eye.slash.fill")
                        .foregroundStyle(Color.showPassword)
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
            makeButton(label: "Login", image: nil, color: Color.loginButton, fontColor: Color.white)
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
        makeButton(label: "Continue with Apple", image: Image(systemName: "apple.logo"), color: Color.textFieldPurple, fontColor: Color.primary)
        makeButton(label: "Continue with Google", image: Image("google"), color: Color.textFieldPurple, fontColor: Color.primary)
        Text("Don't have an account?")
            .padding(.top, 20)
        
        Button {
            
        } label: {
            Text("Sign Up")
                .padding(.bottom, 25)
                .font(.title2)
                .fontWeight(.bold)
                .foregroundStyle(Color.signUp)
        }

    }
}

struct UIPractice: View {
    
    @State private var selector: Selector = .user
    @State private var login: String = ""
    @State private var password: String = ""
    
    var body: some View {
        GeometryReader { proxy in
            ScrollView {
                ZStack {
                    Color.backgroundPurple
                    BackgroundImage()
                        .offset(y: -proxy.size.height * 0.27)
                    VStack {
                        
                        CustomPicker(tab: $selector)
                        
                        TextFiledsSection(login: $login, password: $password)
                        
                        ButtonsSection()
                        
                    }
                    .padding(.top, proxy.size.height / 3.9)
                }
                .ignoresSafeArea()
            }
            .background(Color.backgroundPurple)
            .scrollIndicators(ScrollIndicatorVisibility.hidden)
        }
    }
}

#Preview {
    UIPractice()
}
