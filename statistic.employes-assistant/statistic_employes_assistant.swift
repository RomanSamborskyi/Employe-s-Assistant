//
//  statistic_employes_assistant.swift
//  statistic.employes-assistant
//
//  Created by Roman Samborskyi on 18.02.2024.
//


import WidgetKit
import SwiftUI
import CoreData


struct Provider: AppIntentTimelineProvider {
    
    func fetchDays(from month: MonthEntity) -> [DayEntity] {
        let request = NSFetchRequest<DayEntity>(entityName: CoreDataManager.instanse.dayEntity)
        request.sortDescriptors = [NSSortDescriptor(keyPath: \DayEntity.date, ascending: false)]
        request.predicate = NSPredicate(format: "month == %@", month)
        do {
            return try CoreDataManager.instanse.context.fetch(request)
        } catch let error {
            print("Error of fetching days: \(error.localizedDescription)")
            return []
        }
    }
    
    func countHoursTitle(for month: MonthEntity) -> String {
        let daysArray = fetchDays(from: month)
        var hoursArray: [Double] = []
        for day in daysArray {
            let minutes = Double(day.hours * 60 ) + Double(day.minutes)
            hoursArray.append(minutes)
        }
        let totalHours = String(hoursArray.reduce(0, +) / 60)
        let index = totalHours.firstIndex(of: ".") ?? totalHours.endIndex
        let hour = totalHours[..<index]
        var minute = totalHours[index...]
        minute.removeFirst()
        var convertInToMonute: Int = 0
        if minute.count <= 1 {
            convertInToMonute = (60 * (Int(minute) ?? 0) / 10)
        } else if minute.count >= 2 {
            convertInToMonute = (60 * (Int(minute) ?? 0) / 100)
        }
        return "\(hour):\(convertInToMonute)"
    }
    
    func getMonts() throws -> [MonthEntity] {
        let container = CoreDataManager.instanse.container.viewContext
        
        let request = MonthEntity.fetchRequest()
        let result = try container.fetch(request)
        return result
    }
    
    var dateFormater: DateFormatter = {
        var dateFormater: DateFormatter = DateFormatter()
        dateFormater.dateStyle = .full
        dateFormater.dateFormat = "MMMM YYYY"
        return dateFormater
    }()
    
    func getCurrentMonth() -> MonthEntity? {
        guard let index = try? getMonts().firstIndex(where: { $0.title == dateFormater.string(from: Date()) }) else { return nil }
        return try? getMonts()[index]
    }
    
    func placeholder(in context: Context) -> SimpleEntry {
        SimpleEntry(date: Date(), configuration: ConfigurationAppIntent(), month: getCurrentMonth()!, hoursTitle: countHoursTitle(for: getCurrentMonth()!))
    }
    
    func snapshot(for configuration: ConfigurationAppIntent, in context: Context) async -> SimpleEntry {
        SimpleEntry(date: Date(), configuration: configuration, month: getCurrentMonth()!, hoursTitle: countHoursTitle(for: getCurrentMonth()!))
    }
    
    func timeline(for configuration: ConfigurationAppIntent, in context: Context) async -> Timeline<SimpleEntry> {
        var entries: [SimpleEntry] = []

        // Generate a timeline consisting of five entries an hour apart, starting from the current date.
        let currentDate = Date()
        for hourOffset in 0 ..< 5 {
            let entryDate = Calendar.current.date(byAdding: .hour, value: hourOffset, to: currentDate)!
            if let month = getCurrentMonth() {
                let entry = SimpleEntry(date: entryDate, configuration: configuration, month: month, hoursTitle: countHoursTitle(for: getCurrentMonth()!))
                entries.append(entry)
            }
        }

        return Timeline(entries: entries, policy: .atEnd)
    }
}

struct SimpleEntry: TimelineEntry {
    let date: Date
    let configuration: ConfigurationAppIntent
    let month: MonthEntity
    let hoursTitle: String
}

struct statistic_employes_assistantEntryView : View {
    var entry: Provider.Entry
    @Environment(\.widgetFamily) var family
    @State private var count: Int = 0
    
    @ViewBuilder
    var body: some View {
        switch family {
        case .systemSmall:
            ZStack {
                Circle()
                    .stroke(Color.gray.opacity(0.5),style: StrokeStyle(lineWidth: 10, lineCap: .round))
                    .frame(width: 95)
                Circle()
                    .trim(from: 0.0 , to: CGFloat(entry.month.trim))
                    .stroke(Color.green,style: StrokeStyle(lineWidth: 10, lineCap: .round))
                    .frame(width: 95)
                    .rotationEffect(Angle(degrees: 270.0))
                    .animation(.linear, value: 0.2)
                if Int32(entry.month.totalHours) >= entry.month.monthTarget {
                    Circle()
                        .stroke(Color.green.gradient.opacity(0.3), style: StrokeStyle(lineWidth: 10, lineCap: .round, lineJoin: .round))
                        .frame(width: 105)
                        .blur(radius: 0.5)
                }
                Text("\(entry.hoursTitle)")
                    .font(.system(size: 25, weight: .bold, design: .rounded))
                    .frame(width: 80)
                    .lineLimit(1)
                    .minimumScaleFactor(0.7)
            }
        case .systemMedium:
            HStack {
                ZStack {
                    Circle()
                        .stroke(Color.gray.opacity(0.5),style: StrokeStyle(lineWidth: 10, lineCap: .round))
                        .frame(width: 95)
                    Circle()
                        .trim(from: 0.0 , to: CGFloat(entry.month.trim))
                        .stroke(Color.green,style: StrokeStyle(lineWidth: 10, lineCap: .round))
                        .frame(width: 95)
                        .rotationEffect(Angle(degrees: 270.0))
                        .animation(.linear, value: 0.2)
                    if Int32(entry.month.totalHours) >= entry.month.monthTarget {
                        Circle()
                            .stroke(Color.green.gradient.opacity(0.3), style: StrokeStyle(lineWidth: 10, lineCap: .round, lineJoin: .round))
                            .frame(width: 105)
                            .blur(radius: 0.5)
                    }
                    Text("\(entry.hoursTitle)")
                        .font(.system(size: 25, weight: .bold, design: .rounded))
                        .frame(width: 80)
                        .lineLimit(1)
                        .minimumScaleFactor(0.7)
                }.frame(width: 110, height: 110)
                VStack(alignment: .leading) {
                    HStack {
                        Text("Month details")
                            .font(.title2)
                            .fontWeight(.bold)
                        Image(systemName: "info.bubble.fill")
                            .symbolRenderingMode(.hierarchical)
                            .foregroundStyle(Color.primary)
                            .font(.title2)
                    }
                    HStack {
                        Text("Count of working days:")
                            .foregroundColor(.red.opacity(0.7))
                            .font(.caption)
                        Spacer(minLength: 25)
                        Text("\(count)")
                            .foregroundStyle(Color.red)
                    }
                    HStack {
                        Text("Total salary:")
                            .foregroundColor(.green.opacity(0.7))
                            .font(.caption)
                        Spacer(minLength: 35)
                        Text(String(format: "%.2f", entry.month.totalSalary))
                            .foregroundStyle(Color.green)
                            .lineLimit(1)
                            .minimumScaleFactor(0.8)
                    }
                    HStack {
                        Text("Month target:")
                            .font(.caption)
                            .foregroundColor(Color.primary)
                        Spacer(minLength: 25)
                            Text("\(entry.month.monthTarget)")
                            .foregroundStyle(Color.primary)
                    }
                }
            }.onAppear {
                withAnimation(Animation.spring) {
                    if let array = entry.month.day?.allObjects as? [DayEntity] {
                        self.count = array.count
                    }
                }
            }
        default:
            Text("")
        }
    }
}

struct statistic_employes_assistant: Widget {
    let kind: String = "statistic_employes_assistant"

    var body: some WidgetConfiguration {
        AppIntentConfiguration(kind: kind, intent: ConfigurationAppIntent.self, provider: Provider()) { entry in
            statistic_employes_assistantEntryView(entry: entry)
                .containerBackground(.fill.tertiary, for: .widget)
        }.supportedFamilies([.systemSmall, .systemMedium])
    }
}

extension ConfigurationAppIntent {
    
    fileprivate static var widgetType: ConfigurationAppIntent {
        let intent = ConfigurationAppIntent()
        intent.type = WidgetType.calendar
        return intent
    }
}

#Preview(as: .systemMedium) {
    statistic_employes_assistant()
} timeline: {
    SimpleEntry(date: .now, configuration: .widgetType, month: MonthEntity.init(context: CoreDataManager.instanse.context), hoursTitle: "0:0")
}
