//
//  TrainNavigationApp.swift
//  TrainNavigation
//
//  Created by Zied Mcharek on 14.01.24.
//

import SwiftUI
import SwiftData

@main
struct TrainNavigationApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(NavigationStateManager())
        }
        .modelContainer(for: DataItem.self)
    }
}
