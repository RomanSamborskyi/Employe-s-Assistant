//
//  CustomShareSheetView.swift
//  Employee's Assistant
//
//  Created by Roman Samborskyi on 01.02.2024.
//

import UIKit
import SwiftUI


struct CustomShareSheetView: UIViewControllerRepresentable {
    @Binding var url: URL

    func makeUIViewController(context: Context) -> UIViewController {

        return UIActivityViewController(activityItems: [url], applicationActivities: nil)

    }
    func updateUIViewController(_ uiViewController: UIViewControllerType, context: Context) {
        // You can add additional update logic here if needed
    }
}

