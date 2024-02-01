//
//  ExportCoreDataView.swift
//  Employee's Assistant
//
//  Created by Roman Samborskyi on 31.01.2024.
//

import SwiftUI

struct ExportCoreDataView: View {
    
    @ObservedObject var vm: SettingsViewModel
    
    var body: some View {
        VStack {
            Button(action: {
                vm.exportCoreData()
            }, label: {
                Text("Export")
            })
            
        }
    }
}

#Preview {
    ExportCoreDataView(vm: SettingsViewModel())
}
