//
//  AlternativeIconView.swift
//  Employee's Assistant
//
//  Created by Roman Samborskyi on 27.01.2024.
//

import SwiftUI

struct AlternativeIconView: View {
    
    @State private var checkAnIcon: Bool = false
    @ObservedObject var vm: SettingsViewModel
    private let columns: [GridItem] = [GridItem(), GridItem()]
    
    var body: some View {
        HStack {
            ForEach(vm.icons, id: \.self) { icon in
                ZStack(alignment: .topLeading) {
                    Image(uiImage: UIImage(named: icon ?? "AppIcon") ?? UIImage() )
                        .resizable()
                        .frame(width: 100, height: 100)
                        .clipShape(RoundedRectangle(cornerRadius: 15))
                        .onTapGesture {
                            vm.currentIndex = vm.icons.firstIndex(of: icon) ?? 0
                        }
                    if let currentIcon = UIApplication.shared.alternateIconName {
                        if currentIcon == icon {
                            Image(systemName: "checkmark.seal.fill")
                                .font(.title)
                                .foregroundStyle(Color.blue)
                        }
                    }
                }
            }
        }.onReceive([self.vm.currentIndex].publisher.first()){ value in
            let i = self.vm.icons.firstIndex(of: UIApplication.shared.alternateIconName) ?? 0
            if value != i{
                UIApplication.shared.setAlternateIconName(self.vm.icons[value], completionHandler: {
                    error in
                    if let error = error {
                        print(error.localizedDescription)
                    } else {
                        print("Success!")
                    }
                })
            }
        }
        .onAppear {
            if let currentIcon = UIApplication.shared.alternateIconName {
                if currentIcon == vm.icons[vm.currentIndex] {
                    self.checkAnIcon = true
                } else {
                    self.checkAnIcon = false
                }
            }
        }
    }
}

#Preview {
    AlternativeIconView(vm: SettingsViewModel())
}
