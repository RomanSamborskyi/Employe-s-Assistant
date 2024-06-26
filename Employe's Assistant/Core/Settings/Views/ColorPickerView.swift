//
//  ColorPickerView.swift
//  Employe's Assistant
//
//  Created by Roman Samborskyi on 27.12.2023.
//

import SwiftUI
import WidgetKit


struct ColorPickerView: View {
    @State private var error: AppError? = nil
    @ObservedObject var vm: SettingsViewModel
    @Environment(\.dismiss) var disMiss
    
    var body: some View {
        VStack {
            Image(systemName: "paintpalette.fill")
                .font(.system(size: 65, weight: .bold, design: .rounded))
                .foregroundStyle(Color.accentColor)
            Text("Pick accent color")
                .font(.system(size: 35, weight: .bold, design: .rounded))
                .multilineTextAlignment(.center)
            ColorPicker(selection: $vm.newAccentColor, label: {
                Text("Accent color")
                    .padding()
                    .font(.system(size: 20, weight: .bold, design: .rounded))
            }).padding()
            
            Button(action: {
                vm.addToUserDefaults()
                WidgetCenter.shared.reloadAllTimelines()
                withAnimation(Animation.bouncy) {
                    self.error = AppError.colorChanged
                    HapticEngineManager.instance.hapticNotification(with: .success)
                }
            }, label: {
                Text("SAVE")
                    .padding()
                    .foregroundStyle(Color.white)
                    .frame(maxWidth: .infinity)
                    .background(RoundedRectangle(cornerRadius: 15))
                
            }).padding()
            
            Button(action: {
                vm.resetAccenrColor()
                WidgetCenter.shared.reloadAllTimelines()
                withAnimation(Animation.bouncy) {
                    self.error = AppError.colorChanged
                    HapticEngineManager.instance.hapticNotification(with: .warning)
                }
            }, label: {
                Text("RESET")
                    .padding()
                    .foregroundStyle(Color.white)
                    .frame(maxWidth: .infinity)
                    .background(RoundedRectangle(cornerRadius: 15))
            }).padding()
            Spacer()
        }
        .alert(error?.localizedDescription ?? "", isPresented: Binding(value: $error)) { }
    }
}
