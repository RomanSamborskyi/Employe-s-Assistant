//
//  Tabs.swift
//  Employee's Assistant
//
//  Created by Roman Samborskyi on 03.06.2024.
//

import Foundation



struct AnimatedTab: Identifiable {
    var id: UUID = .init()
    var tab: Tabs
    var isAnimating: Bool?
}
