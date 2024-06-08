//
//  BackUpMainView.swift
//  Employee's Assistant
//
//  Created by Roman Samborskyi on 08.06.2024.
//

import SwiftUI

struct BackUpMainView: View {
    
    @ObservedObject var vm: SettingsViewModel
    @State private var backUp: BackUpMethod = .cloud
    
    var body: some View {
        VStack {
            switch backUp {
            case .local:
                ExportCoreDataView(vm: vm)
            case .cloud:
                SignInView()
            }
        }
        .toolbar {
            ToolbarItem {
                Picker("", selection: $backUp) {
                    ForEach(BackUpMethod.allCases, id: \.self) { tab in
                        Text(tab.description)
                            .padding()
                            .padding(.horizontal, 20)
                    }
                }
                .pickerStyle(.segmented)
            }
        }
    }
}
