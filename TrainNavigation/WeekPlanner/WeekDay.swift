//
//  WeekDay.swift
//  TrainNavigation
//
//  Created by Zied Mcharek on 14.01.24.
//

import SwiftUI
import SwiftData

struct WeekDay: View {
    
    //@Query private var items: [DataItem]
    
    @Query private var items: [WorkoutModelItem]
    
    var date: Date
    var body: some View {
        HStack {
            VStack(alignment: .center){
                Text(date.weekdaySymbol)
                    .font(.title2)
                    .foregroundStyle(.white)
                Text("\(date.day)")
                    .font(.subheadline)
                    .foregroundStyle(.white)
            }.padding(EdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 10))
                .frame(width: 50)
                        
            ForEach(getWorkoutAt(at: self.date), id:\.self) {item in
                NavigationLink(value: "\(self.date):\(item)") {
                    Label("", systemImage: item.workoutActivity.symbol)
                        .font(.largeTitle)
                }
            }
            
            Spacer()
            NavigationLink(value: date) {
                Label("", systemImage: "calendar.badge.plus")
                    .font(.largeTitle)
                    .foregroundColor(.mint)
                    //.disabled(date < Date())
            }.disabled(date < Date())
        }.padding(.horizontal)
            
    }
    
    func getWorkoutAt(at desiredDate: Date) -> [WorkoutModelItem] {
        let calendar = Calendar.current

        // Filtern der Elemente mit dem gewünschten Datum
        let filteredWorkouts = items.filter { workoutItem in
            // Die gewünschten Komponenten (Tag, Monat, Jahr) extrahieren
            let components1 = calendar.dateComponents([.day, .month, .year], from: workoutItem.exactDate)
            let components2 = calendar.dateComponents([.day, .month, .year], from: desiredDate)

            // Die extrahierten Komponenten vergleichen
            return components1.day == components2.day &&
                   components1.month == components2.month &&
                   components1.year == components2.year
        }

        return filteredWorkouts
    }

}

#Preview {
    WeekDay(date: Date())
}

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
