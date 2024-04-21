//
//  MoreDetailsOfDayView.swift
//  Employe's Assistant
//
//  Created by Roman Samborskyi on 02.12.2023.
//

import SwiftUI

struct MoreDetailsOfDayView: View {
    
    let day: Day
    var dateFormater: DateFormatter = {
        var dateFormater: DateFormatter = DateFormatter()
        dateFormater.dateStyle = .full
        return dateFormater
    }()
    
    var body: some View {
        VStack {
            Image(systemName: "info.bubble.fill")
                .font(.system(size: 55, weight: .bold, design: .rounded))
                .foregroundStyle(Color.accentColor)
            Text("Detail of a day:")
                .font(.system(size: 40, weight: .bold, design: .rounded))
            Text(dateFormater.string(from: day.date ?? Date()))
                .font(.title2)
                .fontWeight(.bold)
            HStack {
                Spacer()
                Text("hour")
                    .font(.caption2)
                    .frame(width: 40)
                Text("minute")
                    .font(.caption2)
                    .frame(width: 40)
            }.padding(10)
            HStack {
                Text("Start work at:")
                Spacer()
                Text("\(day.startHours ?? 0)")
                    .frame(width: 40)
                Text("\(day.startMinutes ?? 0)")
                    .frame(width: 40)
            }            
            HStack {
                Text("End work at:")
                Spacer()
                Text("\(day.endHours ?? 0)")
                    .frame(width: 40)
                Text("\(day.endMinutes ?? 0)")
                    .frame(width: 40)
            }
            HStack {
                Text("Pause time:")
                Spacer()
                Text("\(day.pauseTime ?? 0)")
                    .frame(width: 40)
            }
            HStack {
                Text("Total hours:")
                Spacer()
                Text("\(day.hours ?? 0)")
                    .frame(width: 40)
                Text("\(day.minutes ?? 0)")
                    .frame(width: 40)
            }
            Spacer()
        }.padding()
    }
}
