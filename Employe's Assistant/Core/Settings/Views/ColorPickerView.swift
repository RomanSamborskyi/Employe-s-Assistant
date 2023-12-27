//
//  ColorPickerView.swift
//  Employe's Assistant
//
//  Created by Roman Samborskyi on 27.12.2023.
//

import SwiftUI

struct ColorPickerView: View {
    
    @ObservedObject var vm: SettingsViewModel
    @Environment(\.dismiss) var disMiss
    @State private var showAlert: Bool = false
    
    var body: some View {
        VStack {
            Image(systemName: "paintpalette.fill")
                .font(.system(size: 65, weight: .bold, design: .rounded))
                .foregroundStyle(Color.accentColor)
            Text("Pick accent color")
                .font(.system(size: 35, weight: .bold, design: .rounded))
            ColorPicker(selection: $vm.newAccentColor, label: {
                Text("Accent color")
                    .padding()
                    .font(.system(size: 20, weight: .bold, design: .rounded))
            }).padding()
            
            Button(action: {
                vm.addToUserDefaults()
                self.showAlert.toggle()
            }, label: {
                Text("SAVE")
                    .padding()
                    .foregroundStyle(Color.white)
                    .frame(maxWidth: .infinity)
                    .background(RoundedRectangle(cornerRadius: 15))
            }).padding()
            
            Button(action: {
                vm.resetAccenrColor()
                self.showAlert.toggle()
            }, label: {
                Text("RESET")
                    .padding()
                    .foregroundStyle(Color.white)
                    .frame(maxWidth: .infinity)
                    .background(RoundedRectangle(cornerRadius: 15))
            }).padding()
            Spacer()
        }.alert(isPresented: $showAlert) {
            Alert(title: Text("Color changed"), message: Text("Restart application to aply changes"), dismissButton: .default(Text("OK"), action: { disMiss.callAsFunction() }))
        }
    }
}

#Preview {
    ColorPickerView(vm: SettingsViewModel())
}
