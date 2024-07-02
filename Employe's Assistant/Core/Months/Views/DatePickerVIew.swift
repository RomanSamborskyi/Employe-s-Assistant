//
//  DatePickerVIew.swift
//  Employe's Assistant
//
//  Created by Roman Samborskyi on 02.12.2023.
//

import SwiftUI

struct DatePickerVIew: View {
    
    @Binding var date: Date
    
    var body: some View {
        VStack {
            DatePicker("", selection: $date.animation(), displayedComponents: .date)
        }
        .padding(5)
    }
}
