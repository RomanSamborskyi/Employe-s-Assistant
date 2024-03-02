//
//  AppIntent.swift
//  statistic.employes-assistant
//
//  Created by Roman Samborskyi on 18.02.2024.
//

import WidgetKit
import AppIntents

struct ConfigurationAppIntent: WidgetConfigurationIntent {
    static var title: LocalizedStringResource = "Configuration"
    static var description = IntentDescription("This is an example widget.")

    @Parameter(title: "Widget type", default: .progressBar) var type: WidgetType

}

enum WidgetType: String, AppEnum {
    case progressBar, calendar
    
    static var typeDisplayRepresentation: TypeDisplayRepresentation = "Widget type"
    
    static var caseDisplayRepresentations: [WidgetType : DisplayRepresentation] = [
        .calendar : "Calendar",
        .progressBar : "Progress Bar"
    ]
}
