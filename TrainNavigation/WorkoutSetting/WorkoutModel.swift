//
//  WorkoutModel.swift
//  TrainNavigation
//
//  Created by Zied Mcharek on 15.01.24.
//

import Foundation
import SwiftData
import HealthKit
import WorkoutKit

@Model
final class DataItem {
    var date: Date
    var name = [String]()
    
    init(date: Date, name: [String]) {
        self.date = date
        self.name = name
    }
}


@Model final class WorkoutModelItem {
    
    var exactDate: Date
    var workoutActivity: HKWorkoutActivityType
    var workoutName: String
    
    var workoutGoalType: String
    
    //  TODO: Distance, Duration, Energy

    init(exactDate: Date, workoutActivity: HKWorkoutActivityType, workoutName: String, workoutGoalType: String = "open") {
        self.exactDate = exactDate
        self.workoutActivity = workoutActivity
        self.workoutName = workoutName
        self.workoutGoalType = workoutGoalType
    }

}

extension HKWorkoutActivityType: Codable {
    
}


