//
//  WorkoutModel.swift
//  TrainNavigation
//
//  Created by Zied Mcharek on 15.01.24.
//

import Foundation
import SwiftData

@Model
final class DataItem {
    var date: Date
    var name = [String]()
    
    init(date: Date, name: [String]) {
        self.date = date
        self.name = name
    }
}



