//
//  WeekPlannerHeaderView.swift
//  TrainNavigation
//
//  Created by Zied Mcharek on 14.01.24.
//

import SwiftUI

struct WeekPlannerHeaderView: View {
    var today: Date
        
    var body: some View {

            Text("\(today.startOfWeek.fullDate) - \(today.startOfWeek.addingDays(6).fullDate)")
                .font(.callout)
            Divider()
        
    }
}

#Preview {
    WeekPlannerHeaderView(today: Date())
}
