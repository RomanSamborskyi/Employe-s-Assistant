//
//  Enums.swift
//  Employe's Assistant
//
//  Created by Roman Samborskyi on 01.12.2023.
//

import Foundation


enum SelectView: String, Identifiable, CaseIterable {
    var id: Self { self }
    case list, calendar
    
    var description: String {
        switch self {
        case .list:
            "List"
        case .calendar:
            "Calendar"
        }
    }
}

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

enum Tabs {
    case months, statistic, profile, settings
}

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
