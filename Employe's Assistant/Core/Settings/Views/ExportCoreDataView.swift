//
//  ExportCoreDataView.swift
//  Employee's Assistant
//
//  Created by Roman Samborskyi on 31.01.2024.
//

import SwiftUI

struct ExportCoreDataView: View {
    
    @ObservedObject var vm: SettingsViewModel
    @State private var sheetIsPresented: Bool = false
    @State private var sharedURL: URL = URL(string: "google.com")!
    @State private var presentingImportSheet: Bool = false
    @State private var showPopOver: Bool = false
    @State private var popoverText: String = ""
    var body: some View {
        VStack {
            Text("Backup data localy on your device")
                .padding(25)
                .font(.system(size: 35, weight: .bold, design: .rounded))
                .multilineTextAlignment(.center)
            VStack {
                Text("Export backup file")
                    .font(.system(size: 35, weight: .bold, design: .rounded))
                Text("To save your backup file on your device")
                    .padding(.bottom, 15)
                    .font(.system(size: 15))
                Button(action: {
                    sheetIsPresented.toggle()
                }, label: {
                    Label(
                        title: { Text("Export data")},
                        icon: { Image(systemName: "arrow.up") }
                    ).foregroundStyle(Color.primary)
                }).padding()
                    .background( RoundedRectangle(cornerRadius: 15).foregroundStyle(Color.accentColor))
            }.padding()
                .background(RoundedRectangle(cornerRadius: 25).foregroundStyle(Color.accentColor.opacity(0.3)))
            VStack {
                Text("Import backup file")
                    .font(.system(size: 35, weight: .bold, design: .rounded))
                Text("From your device to restore all your data")
                    .padding(.bottom, 15)
                    .font(.system(size: 15))
                Button(action: {
                    presentingImportSheet.toggle()
                }, label: {
                    Label(
                        title: { Text("Import data") },
                        icon: { Image(systemName: "arrow.down") }
                    ).foregroundStyle(Color.primary)
                }).padding()
                    .background( RoundedRectangle(cornerRadius: 15).foregroundStyle(Color.accentColor))
            }.padding()
                .background(RoundedRectangle(cornerRadius: 25).foregroundStyle(Color.accentColor.opacity(0.3)))
            Spacer()
                .frame(height: 130)
        }.onAppear {
            self.sharedURL = vm.exportCoreData()
        }
        .sheet(isPresented: $sheetIsPresented, onDismiss: { vm.delteTempFile(sharedURL) }, content: {
            CustomShareSheetView(url: $sharedURL)
        })
        .fileImporter(isPresented: $presentingImportSheet, allowedContentTypes: [.json]) { result in
            switch result {
            case .success(let url):
                vm.importJSONFile(url)
                self.showPopOver.toggle()
                self.popoverText = "Data impoted succesfully"
                HapticEngineManager.instance.hapticNotification(with: .success)
            case .failure(let error):
                print(error.localizedDescription)
                self.showPopOver.toggle()
                self.popoverText = "Error of importing data"
                HapticEngineManager.instance.hapticNotification(with: .error)
            }
        }
        .overlay(content: {
            if showPopOver {
                CustomPopOver(vm: vm, trigerPopOver: $showPopOver, text: popoverText, iconName: "checkmark.square.fill")
            }
        })
    }
}

#Preview {
    ExportCoreDataView(vm: SettingsViewModel())
}
