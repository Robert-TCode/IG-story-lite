//
//  StoryRootView.swift
//  IGStoryLite
//
//  Created by TCode on 7/7/25.
//

import SwiftUI

struct StoryRootView: View {
    @StateObject var coordinator: StoryCoordinator

    var body: some View {
        NavigationStack(path: $coordinator.navigationPath) {
            coordinator.makeRootView()
                .navigationDestination(for: StoryScreen.self) { screen in
                    coordinator.makeView(for: screen)
                }
        }
    }
}
