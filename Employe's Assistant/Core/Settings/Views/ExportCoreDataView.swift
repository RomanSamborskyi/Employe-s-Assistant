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
    @State private var error: AppError? = nil
    
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
                    .background( RoundedRectangle(cornerRadius: 15).foregroundStyle(Color.newAccentColor))
            }
            .padding()
            .background(RoundedRectangle(cornerRadius: 25).foregroundStyle(Color.newAccentColor.opacity(0.3)))
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
                    .background( RoundedRectangle(cornerRadius: 15).foregroundStyle(Color.newAccentColor))
            }.padding()
                .background(RoundedRectangle(cornerRadius: 25).foregroundStyle(Color.newAccentColor.opacity(0.3)))
            Spacer()
                .frame(height: 130)
        }
        .onAppear {
            self.sharedURL = vm.exportCoreData()
        }
        .sheet(isPresented: $sheetIsPresented, onDismiss: {
            if vm.checkIfSavedSuccessfully(sharedURL) {
                self.error = AppError.dataExportedSuccessfully
            } else {
                self.error = AppError.errorOfExportBackup
            }
            vm.delteTempFile(sharedURL)
        }, content: {
            CustomShareSheetView(url: $sharedURL)
        })
        .fileImporter(isPresented: $presentingImportSheet, allowedContentTypes: [.json]) { result in
            switch result {
            case .success(let url):
                vm.importJSONFile(url)
                self.error = AppError.dataImported
                HapticEngineManager.instance.hapticNotification(with: .success)
            case .failure(let error):
                print(error.localizedDescription)
                self.error = AppError.errorOfImportBackup
                HapticEngineManager.instance.hapticNotification(with: .error)
            }
        }
        .alert(error?.localizedDescription ?? "", isPresented: Binding(value: $error)) { }
    }
}

#Preview {
    ExportCoreDataView(vm: SettingsViewModel())
}
