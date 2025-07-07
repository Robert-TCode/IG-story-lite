//
//  StoryCoordinator.swift
//  IGStoryLite
//
//  Created by TCode on 7/7/25.
//


import SwiftUI

final class StoryCoordinator: Coordinator {
    @Published var navigationPath = [StoryScreen]()

    private let container: DIContainer

    init(container: DIContainer) {
        self.container = container
    }

    var initialScreen: StoryScreen { .storyList }

    @MainActor
    func makeRootView() -> some View {
        makeView(for: initialScreen)
    }

    @MainActor
    @ViewBuilder
    func makeView(for screen: StoryScreen) -> some View {
        switch screen {
        case .storyList:
            Text("Story List view")
        case let .story(story):
            Text("Story view")
        }
    }
}
