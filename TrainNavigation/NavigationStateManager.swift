//
//  NavigationStateManager.swift
//  TrainNavigation
//
//  Created by Zied Mcharek on 15.01.24.
//

import Foundation
import SwiftUI


// MARK: - NavigationStateManager
// An ObservableObject class managing the navigation state of the app
class NavigationStateManager: ObservableObject {
    // MARK: - Published Properties
    // Published property to track the selection path for navigation
    @Published var selectionPath = NavigationPath()

    // MARK: - Methods
    // Method to reset the selection path, effectively popping to the root view
    func popToRoot() {
        selectionPath = NavigationPath()
    }

    // Method to navigate back by removing the last element from the selection path
    func popView() {
        selectionPath.removeLast()
    }
}

// MARK: - NavigationBackButton Modifier
// A custom ViewModifier to add a back button to the navigation bar
struct NavigationBackButton: ViewModifier {
    @EnvironmentObject var nav: NavigationStateManager
    func body(content: Content) -> some View {
        return content
            .toolbar{
                ToolbarItem(placement: .topBarLeading) {
                    Button {
                        nav.popView()
                    } label: {
                        Image(systemName: "chevron.backward.circle")
                    }
                }
            }
    }
}
