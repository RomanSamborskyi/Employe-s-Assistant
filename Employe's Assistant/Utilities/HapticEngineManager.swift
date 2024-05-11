//
//  HapticEngineManager.swift
//  Employee's Assistant
//
//  Created by Roman Samborskyi on 26.03.2024.
//


import UIKit


class HapticEngineManager {
    static let instance: HapticEngineManager = HapticEngineManager()
    ///Make notification haptic feadback: .error, .success, .warning
    func hapticNotification(with: UINotificationFeedbackGenerator.FeedbackType) {
        let generator: UINotificationFeedbackGenerator = UINotificationFeedbackGenerator()
        generator.notificationOccurred(with)
    }
    ///Make haptic feadback: .heavy, .light, .medium, .rigid, .soft
    func makeFeadback(with: UIImpactFeedbackGenerator.FeedbackStyle) {
        let generator: UIImpactFeedbackGenerator = UIImpactFeedbackGenerator.init(style: with)
        generator.impactOccurred()
    }
}

