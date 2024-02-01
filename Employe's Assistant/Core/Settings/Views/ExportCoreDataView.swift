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
    
    var body: some View {
        VStack {
            Button(action: {
                sheetIsPresented.toggle()
            }, label: {
                Label(
                    title: { Text("Export data")},
                    icon: { Image(systemName: "arrow.up") }
                ).foregroundStyle(Color.primary)
            }).padding()
                .background( RoundedRectangle(cornerRadius: 15).foregroundStyle(Color.accentColor))
            Button(action: {
                presentingImportSheet.toggle()
            }, label: {
                Label(
                    title: { Text("Import data") },
                    icon: { Image(systemName: "arrow.down") }
                ).foregroundStyle(Color.primary)
            }).padding()
                .background( RoundedRectangle(cornerRadius: 15).foregroundStyle(Color.accentColor))

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
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
}

#Preview {
    ExportCoreDataView(vm: SettingsViewModel())
}
