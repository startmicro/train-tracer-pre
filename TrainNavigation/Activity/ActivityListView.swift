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
    
    var body: some View {
        List {
            ForEach(HKWorkoutActivityType.allActivityTypes, id: \.self) {activity in
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
    }
}

#Preview {
    ActivityListView(selectedDate: Date())
}
