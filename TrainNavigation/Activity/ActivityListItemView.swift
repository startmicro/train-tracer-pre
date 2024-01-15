//
//  ActivityListItemView.swift
//  TrainNavigation
//
//  Created by Zied Mcharek on 14.01.24.
//

import SwiftUI
import HealthKit

struct ActivityWithDate: Hashable {
    let activityDate: Date
    let activity: HKWorkoutActivityType
}

struct ActivityListItemView: View {
    let activity: HKWorkoutActivityType
    var selectedDate: Date
    var body: some View {
        NavigationLink(value: ActivityWithDate(activityDate: selectedDate, activity: activity)) {
                Label(activity.displayName, systemImage: activity.symbol)
      
        }
    }
}

#Preview {
    ActivityListItemView(activity: .rugby, selectedDate: Date())
}

