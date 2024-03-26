//
//  AlternativeIconView.swift
//  Employee's Assistant
//
//  Created by Roman Samborskyi on 27.01.2024.
//

import SwiftUI

struct AlternativeIconView: View {
    
    @ObservedObject var vm: SettingsViewModel
    private let columns: [GridItem] = [GridItem(), GridItem(), GridItem()]
    private var checkmark: some View {
              Image(systemName: "checkmark.seal.fill")
                    .font(.title)
                    .foregroundStyle(Color.accentColor)
                    .offset(x: -10, y: -10)
    }
    
    var body: some View {
        VStack {
            Image(systemName: "photo.on.rectangle.angled")
                .padding()
                .font(.system(size: 65, weight: .bold, design: .rounded))
                .foregroundStyle(Color.accentColor)
            Text("Pick an icon")
                .padding()
                .font(.system(size: 45, weight: .bold, design: .rounded))
                .foregroundStyle(Color.accentColor)
            LazyVGrid(columns: columns, spacing: 30) {
                ForEach(vm.icons, id: \.self) { icon in
                    ZStack(alignment: .topLeading) {
                        Image(uiImage: UIImage(named: icon ?? "AppIcon") ?? UIImage() )
                            .resizable()
                            .frame(width: 100, height: 100)
                            .clipShape(RoundedRectangle(cornerRadius: 25))
                            .shadow(color: vm.newAccentColor ,radius: 5, x: 5, y: 5)
                            .onTapGesture {
                                vm.currentIndex = vm.icons.firstIndex(of: icon) ?? 0
                                HapticEngineManager.instance.hapticNotification(with: .success)
                            }
                        if vm.checkIcon(icon: icon) {
                               checkmark
                        }
                    }
                }
            }.padding()
            .onReceive([self.vm.currentIndex].publisher.first()){ value in
                let i = self.vm.icons.firstIndex(of: UIApplication.shared.alternateIconName) ?? 0
                if value != i{
                    UIApplication.shared.setAlternateIconName(self.vm.icons[value], completionHandler: {
                        error in
                        if let error = error {
                            print(error.localizedDescription)
                        } else {
                
                        }
                    })
                }
           }
            Spacer()
                .frame(height: 200)
        }
    }
}

#Preview {
    AlternativeIconView(vm: SettingsViewModel())
}
