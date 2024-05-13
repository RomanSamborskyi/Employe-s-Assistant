//
//  Enums.swift
//  Employe's Assistant
//
//  Created by Roman Samborskyi on 01.12.2023.
//

import Foundation

//List of view in month detail view
enum SelectView: String, Identifiable, CaseIterable {
    var id: Self { self }
    case list, calendar
    
    var description: String {
        switch self {
        case .list:
            NSLocalizedString("List", comment: "")
        case .calendar:
            NSLocalizedString("Calendar", comment: "")
        }
    }
}
//Type of statistic in statistic view
enum StatisticType: String, Identifiable, CaseIterable {
    var id: Self { self }
    case hours, workingDays, salary
    
    var description: String {
        switch self {
        case .hours:
            return NSLocalizedString("hours", comment: "")
        case .workingDays:
            return NSLocalizedString("working days", comment: "")
        case .salary:
            return NSLocalizedString("salary", comment: "")
        }
    }
}
//Main tabs
enum Tabs {
    case months, statistic, settings
}
//String representation of hours which used in addNewDay view
enum Hours: String, CaseIterable, Identifiable {
    
    var id: Self { self }
    
    case zero, one, two, three, four, five, six, seven, eight, nine, ten, eleven, twelve, thirteen, fourteen, fifteen, sixteen, seventeen, eighteen, nineteen, twenty, twenty_one, twentee_two, twentee_three, twenty_four
    var description: String {
        switch self {
        case .zero:
            "0"
        case .one:
            "1"
        case .two:
            "2"
        case .three:
            "3"
        case .four:
            "4"
        case .five:
            "5"
        case .six:
            "6"
        case .seven:
            "7"
        case .eight:
            "8"
        case .nine:
            "9"
        case .ten:
            "10"
        case .eleven:
            "11"
        case .twelve:
            "12"
        case .thirteen:
            "13"
        case .fourteen:
            "14"
        case .fifteen:
            "15"
        case .sixteen:
            "16"
        case .seventeen:
            "17"
        case .eighteen:
             "18"
        case .nineteen:
            "19"
        case .twenty:
            "20"
        case .twenty_one:
            "21"
        case .twentee_two:
            "22"
        case .twentee_three:
            "23"
        case .twenty_four:
            "24"
        }
    }
}
//String representation of minutes which used in addNewDay view
enum Minutes: String, CaseIterable, Identifiable {
    
    var id: Self { self }
    
    case zero, fifteen, thirtee,  fourtee_five
    var description: String {
        switch self {
        case .zero:
            "0"
        case .fifteen:
            "15"
        case .thirtee:
            "30"
        case .fourtee_five:
            "45"
        }
    }
}
//String representation of minutes which used in addNewDay view
enum Pause: String, CaseIterable, Identifiable {
    
    var id: Self { self }
    
    case zero, five, ten, fifteen, twentee, twentee_five, thirtee, thirtee_five, fourtee, fourtee_five, fiftee, fiftee_five, one_houre
    var description: String {
        switch self {
        case .zero:
            "0"
        case .five:
            "5"
        case .ten:
            "10"
        case .fifteen:
            "15"
        case .twentee:
            "20"
        case .twentee_five:
            "25"
        case .thirtee:
            "30"
        case .thirtee_five:
            "35"
        case .fourtee:
            "40"
        case .fourtee_five:
            "45"
        case .fiftee:
            "50"
        case .fiftee_five:
            "55"
        case .one_houre:
            "60"
        }
    }
}
//List of months which used for adding the new month
enum Monthes: String, CaseIterable, Identifiable {
    
    var id: Self { self }
    
    case empty, january, february, march, april, may, june, luly, august, september, october, november, december
    
    var description: String {
        switch self {
        case .empty:
           NSLocalizedString("Not selected", comment: "")
        case .january:
            NSLocalizedString("January", comment: "")
        case .february:
            NSLocalizedString("February", comment: "")
        case .march:
            NSLocalizedString("March", comment: "")
        case .april:
            NSLocalizedString("April", comment: "")
        case .may:
            NSLocalizedString("May", comment: "")
        case .june:
            NSLocalizedString("June", comment: "")
        case .luly:
            NSLocalizedString("July", comment: "")
        case .august:
            NSLocalizedString("August", comment: "")
        case .september:
            NSLocalizedString("September", comment: "")
        case .october:
            NSLocalizedString("October", comment: "")
        case .november:
            NSLocalizedString("November", comment: "")
        case .december:
            NSLocalizedString("December", comment: "")
        }
    }
}
//List of onboarding pages
enum OnboardingPages: CaseIterable {
    case first, second, thread, fourth
}
//Type of chart
enum ChartType: String, Identifiable, CaseIterable {
    var id: Self { self }
    case barMark, lineMark, custom
    
    var description: String {
        switch self {
        case .barMark:
            NSLocalizedString("Bar Chart", comment: "")
        case .lineMark:
            NSLocalizedString("Line Chart", comment: "")
        case .custom:
            NSLocalizedString("Minimalistic", comment: "")
        }
    }
}
//App posible errors
enum AppError: Error, LocalizedError {
    case noDataFetched, errorOfExportBackup, errorSavingToCoreData, noDataFromCoreData, errorOfImportBackup, emptyMonth, monthAlreadyExist, setAllDayFields, existingDay, dayIsInTheFeature, dataImported, colorChanged
    
    var errorDescription: String? {
        switch self {
        case .noDataFetched:
            return NSLocalizedString("Error of fetching data", comment: "")
        case .errorOfExportBackup:
            return NSLocalizedString("Error of export backup file", comment: "")
        case .errorSavingToCoreData:
            return NSLocalizedString("Error of saving data", comment: "")
        case .noDataFromCoreData:
            return NSLocalizedString("Error of fetching data", comment: "")
        case .errorOfImportBackup:
            return NSLocalizedString("Error of importing data", comment: "")
        case .emptyMonth:
            return NSLocalizedString("Please, select a month", comment: "")
        case .monthAlreadyExist:
            return NSLocalizedString("The month is already exist", comment: "")
        case .setAllDayFields:
            return NSLocalizedString("Set all required fields", comment: "")
        case .existingDay:
            return NSLocalizedString("You already added this day", comment: "")
        case .dayIsInTheFeature:
            return NSLocalizedString("This day is in the future", comment: "")
        case .dataImported:
            return NSLocalizedString("Data impoted succesfully", comment: "")
        case .colorChanged:
            return NSLocalizedString("Color was successfully changed", comment: "")
        }
    }
    var message: String? {
        switch self {
        case .colorChanged:
            return NSLocalizedString("Restart app to aply changes", comment: "")
        default:
            return nil
        }
    }
}
