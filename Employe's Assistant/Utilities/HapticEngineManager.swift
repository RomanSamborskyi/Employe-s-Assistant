//
//  HapticEngineManager.swift
//  Employee's Assistant
//
//  Created by Roman Samborskyi on 26.03.2024.
//


import UIKit


class HapticEngineManager {
    static let instance: HapticEngineManager = HapticEngineManager()
    
    func hapticNotification(with: UINotificationFeedbackGenerator.FeedbackType) {
        let generator: UINotificationFeedbackGenerator = UINotificationFeedbackGenerator()
        generator.notificationOccurred(with)
    }
    
    func makeFeadback(with: UIImpactFeedbackGenerator.FeedbackStyle) {
        let generator: UIImpactFeedbackGenerator = UIImpactFeedbackGenerator.init(style: with)
        generator.impactOccurred()
    }
}
