//
//  RootCoordinatorView.swift
//  IGStoryLite
//
//  Created by TCode on 7/7/25.
//

import SwiftUI

struct RootCoordinatorView: View {
    @EnvironmentObject private var appRouter: AppRouter
    private let container: DIContainer

    init(container: DIContainer) {
        self.container = container
    }

    var body: some View {
        switch appRouter.route {
        case .main:
            StoryRootView(coordinator: StoryCoordinator(container: container))

        case .auth:
            // Auth flow not implemented for this challenge
            Text("Auth not implemented")
        }
    }
}
