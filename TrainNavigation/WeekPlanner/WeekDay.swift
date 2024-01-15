//
//  WeekDay.swift
//  TrainNavigation
//
//  Created by Zied Mcharek on 14.01.24.
//

import SwiftUI
import SwiftData

struct WeekDay: View {
    
    @Query private var items: [DataItem]
    
    var date: Date
    var body: some View {
        HStack {
            VStack(alignment: .center){
                Text(date.weekdaySymbol)
                    .font(.title2)
                Text("\(date.day)")
                    .font(.subheadline)
            }.padding(EdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 10))
                .frame(width: 50)
            
            

            ForEach(getWorkoutAt(date: self.date), id:\.self) {item in
                NavigationLink(value: "Hallo") {
                    Label("", systemImage: item)
                        .font(.largeTitle)
                }
            }
            
            Spacer()
            
            NavigationLink(value: date) {
                Label("", systemImage: "calendar.badge.plus")
                    .font(.largeTitle)
            }
        }.padding(.horizontal)
    }
    
    func getWorkoutAt(date: Date) -> [String] {
        if let item = items.first(where: { $0.date == date }) {
            return item.name
        } else {
            return [""] // Falls die ID nicht gefunden wurde
        }
    }
}

#Preview {
    WeekDay(date: Date())
}


/*
 
 */


extension Date {
    
    var weekdaySymbol: String {
        let formatter = DateFormatter()
        formatter.dateFormat = "EEEEEE"
        formatter.locale = Locale(identifier: Locale.current.identifier)
        return formatter.string(from: self)
    }
    
    var fullDate: String {
        let formatter = DateFormatter()
        formatter.dateFormat = "E d. MMM. yyyy"
        formatter.locale = Locale.current
        return formatter.string(from: self)
    }
    
    var day: Int {
        Calendar.current.component(.day, from: self)
    }
    
    
    var startOfWeek: Date {
        Calendar.current.date(from: Calendar.current.dateComponents([.yearForWeekOfYear, .weekOfYear], from: self)) ?? self
    }

    func addingDays(_ days: Int) -> Date {
        Calendar.current.date(byAdding: .day, value: days, to: self) ?? self
    }
}
