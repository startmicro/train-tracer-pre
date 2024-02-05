//
//  ContentView.swift
//  TrainNavigation
//
//  Created by Zied Mcharek on 14.01.24.
//

import SwiftUI
import HealthKit

struct ContentView: View {
    
    //  Navigation State Manager for programticly navigation
    @EnvironmentObject var navigationStateManager: NavigationStateManager
    
    //  TODO: just temporarly for swiftData clean
    @Environment(\.modelContext) private var context
        
    @State private var today:Date = .now
    
    var dayWithOffset: (Int) -> Date {
        {
            input in
            self.today.startOfWeek.addingDays(input)
        }
    }
    
    func removeStoredData() {
        do {
            try context.delete(model: WorkoutModelItem.self)
        } catch {
            fatalError(error.localizedDescription)
        }
    }
    
    func goToCurrentWeek() {
        today = .now
    }
    
    var body: some View {
        NavigationStack(path: $navigationStateManager.selectionPath) {
            WeekPlannerHeaderView(today: today)
            Spacer()
            VStack(alignment: .center, spacing: 0) {
                ForEach(0..<7) { dayIndex in
                    WeekDay(date: self.dayWithOffset(dayIndex))
                        .frame(maxHeight: .infinity)
                        .background(dayIndex % 2 == 0 ? Color("row1") : Color("row2"))
                    Divider()
                }
            }.gesture(
                DragGesture()
                    .onEnded { gesture in
                        if gesture.translation.width < 0 {
                            self.today = self.today.addingDays(7)
                        } else if gesture.translation.width > 0 {
                            self.today = self.today.addingDays(-7)
                        }
                    })
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    Button(action: removeStoredData) {
                        Label("Remove stored Data", systemImage: "trash")
                    }
                }
                ToolbarItem(placement: .topBarLeading) {
                    Button(action: goToCurrentWeek) {
                        Label("current week", systemImage: "dot.circle.and.hand.point.up.left.fill")
                    }
                }
            }
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .principal) {
                    Text("Week Planner")
                        .font(.largeTitle)
                        .accessibilityAddTraits(.isHeader)
                }
            }
            .navigationDestination(for: Date.self) { activityDate in
                ActivityListView(selectedDate: activityDate)
            }
            .navigationDestination(for: ActivityWithDate.self) { activityWithDate in
                WorkoutSettingView(dayScheduledActivity: activityWithDate)
            }
            .navigationDestination(for: String.self) { activityName in
                Text(activityName)
            }
            
        }
    }
}
/*
#Preview {
    ContentView()
}
*/
