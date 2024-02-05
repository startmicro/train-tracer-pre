//
//  ListView.swift
//  TrainNavigation
//
//  Created by Zied Mcharek on 14.01.24.
//

import SwiftUI
import HealthKit

struct ActivityListView: View {
    
    @EnvironmentObject var nav: NavigationStateManager
    let selectedDate: Date
    let dateFormatter = DateFormatter()
    
    @State private var searchActivity = ""
    
    var filteredActivity: [HKWorkoutActivityType] {
        guard !searchActivity.isEmpty else {return HKWorkoutActivityType.allActivityTypes}
        return HKWorkoutActivityType.allActivityTypes.filter {
            $0.displayName.localizedStandardContains(searchActivity)
        }
    }
    
    var body: some View {
        List {
            ForEach(filteredActivity, id: \.self) {activity in
                ActivityListItemView(activity: activity, selectedDate: selectedDate)
                    .padding()
            }
        }
        .onAppear() {
            dateFormatter.dateFormat = "dd/MM/YY"
        }
        .listStyle(.plain)
        .navigationTitle("Choose your Activity")
        .navigationBarBackButtonHidden()
        .modifier(NavigationBackButton())
        .searchable(text: $searchActivity, placement: .navigationBarDrawer(displayMode: .always), prompt: "Search Activity")
    }
}

#Preview {
    ActivityListView(selectedDate: Date())
}
