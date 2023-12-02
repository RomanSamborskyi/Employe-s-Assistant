//
//  MoreDetailsOfDayView.swift
//  Employe's Assistant
//
//  Created by Roman Samborskyi on 02.12.2023.
//

import SwiftUI

struct MoreDetailsOfDayView: View {
    
    let day: DayEntity
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
            Text("Detail of day:")
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
                Text("\(day.startHours)")
                    .frame(width: 40)
                Text("\(day.minutes)")
                    .frame(width: 40)
            }            
            HStack {
                Text("End work at:")
                Spacer()
                Text("\(day.endHours)")
                    .frame(width: 40)
                Text("\(day.endMinutes)")
                    .frame(width: 40)
            }
            HStack {
                Text("Pause time:")
                Spacer()
                Text("\(day.pauseTime)")
                    .frame(width: 40)
            }
            Spacer()
        }.padding()
    }
}

#Preview {
    MoreDetailsOfDayView(day: DayEntity(context: CoreDataManager().context))
}
