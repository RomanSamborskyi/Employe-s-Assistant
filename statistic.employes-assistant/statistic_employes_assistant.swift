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
    
    let viewModel = WidgetViewModel.instanse
    
    func placeholder(in context: Context) -> SimpleEntry {
        SimpleEntry(date: Date(), configuration: ConfigurationAppIntent(), month: viewModel.getCurrentMonth()!, hoursTitle: viewModel.countHoursTitle(for: viewModel.getCurrentMonth()!), color: viewModel.getSavedColor() ?? Color.accentColor)
    }
    
    func snapshot(for configuration: ConfigurationAppIntent, in context: Context) async -> SimpleEntry {
        SimpleEntry(date: Date(), configuration: configuration, month: viewModel.getCurrentMonth()!, hoursTitle: viewModel.countHoursTitle(for: viewModel.getCurrentMonth()!), color: viewModel.getSavedColor() ?? Color.accentColor)
    }
    
    func timeline(for configuration: ConfigurationAppIntent, in context: Context) async -> Timeline<SimpleEntry> {
        var entries: [SimpleEntry] = []
        
        let currentDate = Date()
        for hourOffset in 0 ..< 5 {
            let entryDate = Calendar.current.date(byAdding: .hour, value: hourOffset, to: currentDate)!
            if let month = viewModel.getCurrentMonth() {
                let entry = SimpleEntry(date: entryDate, configuration: configuration, month: month, hoursTitle: viewModel.countHoursTitle(for: viewModel.getCurrentMonth()!), color: viewModel.getSavedColor() ?? Color.accentColor)
                entries.append(entry)
            }
        }
        
        return Timeline(entries: entries, policy: .atEnd)
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

struct statistic_employes_assistantEntryView: View {
    var entry: Provider.Entry
    @Environment(\.widgetFamily) var family
    @State private var days: [String] = ["Mon", "Tue", "Wed", "Thu", "Fri", "Sat", "Sun"]
    @State private var columns: [GridItem] = Array(repeating: GridItem(.flexible()), count: 7)
    @State private var count: Int = 0
    let dateFormatter: DateFormatter = {
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .short
        return dateFormatter
    }()
    
    @ViewBuilder
    var body: some View {
        switch family {
        case .systemSmall:
          smallWidget(entry)
        case .systemMedium:
            if entry.configuration.type == .progressBar {
               mediumProgressBarWidget(entry, count: count)
                    .onAppear {
                        withAnimation(Animation.spring) {
                            if let array = entry.month.day?.allObjects as? [DayEntity] {
                                self.count = array.count
                            }
                        }
                    }
            } else if entry.configuration.type == .calendar {
                mediumCalendarWidget(entry, days: days, columns: columns, dateFormatter: dateFormatter)
            }
        default:
            EmptyView()
        }
    }
}


#Preview(as: .systemMedium) {
    statistic_employes_assistant()
} timeline: {
    SimpleEntry(date: .now, configuration: .widgetType, month: MonthEntity.init(context: CoreDataManager.instanse.context), hoursTitle: "0:0", color: Color.accentColor)
}

@ViewBuilder
func smallWidget(_ entry: Provider.Entry) -> some View {
    ZStack {
        Circle()
            .stroke(Color.gray.opacity(0.5),style: StrokeStyle(lineWidth: 10, lineCap: .round))
            .frame(width: 95)
        Circle()
            .trim(from: 0.0 , to: CGFloat(Provider().viewModel.trimCalculation(for: entry.month)))
            .stroke(Int32(entry.month.totalHours) >= entry.month.monthTarget ? Color.green : entry.color,style: StrokeStyle(lineWidth: 10, lineCap: .round))
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
}

@ViewBuilder
func mediumProgressBarWidget(_ entry: Provider.Entry, count: Int) -> some View {
    HStack {
        ZStack {
            Circle()
                .stroke(Color.gray.opacity(0.5),style: StrokeStyle(lineWidth: 10, lineCap: .round))
                .frame(width: 95)
            Circle()
                .trim(from: 0.0 , to: CGFloat(Provider().viewModel.trimCalculation(for: entry.month)))
                .stroke(Int32(entry.month.totalHours) >= entry.month.monthTarget ? Color.green : entry.color ,style: StrokeStyle(lineWidth: 10, lineCap: .round))
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
                    .foregroundStyle(entry.color)
                    .font(.title2)
            }
            HStack {
                Text("Count of working days:")
                    .foregroundColor(.gray)
                    .font(.caption)
                Spacer(minLength: 25)
                Text("\(count)")
                    .foregroundStyle(Color.gray)
            }
            HStack {
                Text("Total salary:")
                    .foregroundColor(.gray)
                    .font(.caption)
                Spacer(minLength: 35)
                Text(String(format: "%.2f", entry.month.totalSalary))
                    .foregroundStyle(Color.gray)
                    .lineLimit(1)
                    .minimumScaleFactor(0.8)
            }
            HStack {
                Text("Month target:")
                    .font(.caption)
                    .foregroundColor(entry.color)
                Spacer(minLength: 25)
                Text("\(entry.month.monthTarget)")
                    .foregroundStyle(entry.color)
            }
        }
    }
}

@ViewBuilder
func mediumCalendarWidget(_ entry: Provider.Entry, days: [String], columns: [GridItem], dateFormatter: DateFormatter) -> some View {
    HStack {
        ZStack {
            Circle()
                .stroke(Color.gray.opacity(0.5),style: StrokeStyle(lineWidth: 10, lineCap: .round))
                .frame(width: 90)
            Circle()
                .trim(from: 0.0 , to: CGFloat(Provider().viewModel.trimCalculation(for: entry.month)))
                .stroke(Int32(entry.month.totalHours) >= entry.month.monthTarget ? Color.green : entry.color ,style: StrokeStyle(lineWidth: 10, lineCap: .round))
                .frame(width: 90)
                .rotationEffect(Angle(degrees: 270.0))
                .animation(.linear, value: 0.2)
            if Int32(entry.month.totalHours) >= entry.month.monthTarget {
                Circle()
                    .stroke(Color.green.gradient.opacity(0.3), style: StrokeStyle(lineWidth: 10, lineCap: .round, lineJoin: .round))
                    .frame(width: 90)
                    .blur(radius: 0.5)
            }
            Text("\(entry.hoursTitle)")
                .font(.system(size: 15, weight: .bold, design: .rounded))
                .frame(width: 50)
                .lineLimit(1)
                .minimumScaleFactor(0.7)
        }.frame(width: 100, height: 100)
        VStack {
            HStack {
                ForEach(days, id: \.self) { day in
                    Text(LocalizedStringKey(day))
                        .padding(.horizontal,Locale.preferredLanguages.first! == "uk-UA" ? 2.65 : 0)
                        .font(.system(size: 10.5, weight: .bold, design: .rounded))
                        .foregroundStyle(entry.color).contrast(1.5)
                }
            }
            LazyVGrid(columns: columns, spacing: 8) {
                ForEach(Provider().viewModel.fetchDates(entry.month)) { day in
                    if day.day == -1 {
                        Text("")
                    } else {
                        Text("\(day.day)")
                            .foregroundStyle(dateFormatter.string(from: day.date) == dateFormatter.string(from: Date()) ? entry.color : Color.primary)
                            .font(.system(size: 14, weight: .semibold, design: .rounded))
                            .fontWeight(dateFormatter.string(from: day.date) == dateFormatter.string(from: Date()) ? .heavy : nil)
                            .background(Provider().viewModel.checkDays(day, entry.month) ? RoundedRectangle(cornerRadius: 5)
                                .frame(width: 20,height: 20)
                                .foregroundStyle(entry.color.opacity(0.5)) : nil )
                            .overlay {
                                if dateFormatter.string(from: day.date) == dateFormatter.string(from: Date()) {
                                    RoundedRectangle(cornerRadius: 5)
                                        .stroke(lineWidth: 2)
                                        .foregroundStyle(entry.color)
                                        .frame(width: 20, height: 20)
                                }
                            }
                    }
                }
            }
        }.frame(width: 190)
            .padding(.horizontal, 5)
    }
}
