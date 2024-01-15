//
//  ContentView.swift
//  TrainNavigation
//
//  Created by Zied Mcharek on 14.01.24.
//

import SwiftUI
import HealthKit

struct ContentView: View {
    
    @EnvironmentObject var nav: NavigationStateManager
    @Environment(\.modelContext) private var context
    
    let today = Date()
    
    var dayWithOffset: (Int) -> Date {
        {
            input in
            self.today.startOfWeek.addingDays(input)
        }
    }
    
    func removeStoredData() {
        do {
            try context.delete(model: DataItem.self)
        } catch {
            fatalError(error.localizedDescription)
        }
    }
    
    var body: some View {
        NavigationStack(path: $nav.selectionPath) {
            WeekPlannerHeaderView(today: today)
            Spacer()
            VStack(alignment: .center) {
                ForEach(0..<7) { dayIndex in
                    WeekDay(date: self.dayWithOffset(dayIndex))
                        .frame(maxHeight: .infinity)
                    Divider()
                }
            }
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button(action: removeStoredData) {
                        Label("Remove stored Data", systemImage: "trash")
                    }
                }
            }
            .padding()
            .navigationTitle("Week Planner")
            .navigationDestination(for: Date.self) {activityDate in
                ActivityListView(selectedDate: activityDate)
            }
            .navigationDestination(for: ActivityWithDate.self) {activityWithDate in
                WorkoutSettingView(activityWithDate: activityWithDate)
            }
        }
    }
}
/*
#Preview {
    ContentView()
}*/
