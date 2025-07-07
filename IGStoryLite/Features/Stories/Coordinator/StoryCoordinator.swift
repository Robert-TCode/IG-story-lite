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
            StoryListView {
                StoryListViewModel(
                    fetchStoriesUseCase: self.container.resolve(),
                    navigator: self
                )
            }
        case .story:
            StoriesView {
                StoriesViewModel(
                    fetchStoriesUseCase: self.container.resolve(),
                    markStoryAsSeenUseCase: self.container.resolve(),
                    setLikeStatusUseCase: self.container.resolve(),
                    navigator: self
                )
            }
        }
    }
}

// MARK: - UserStoriesNavigationHandling

extension StoryCoordinator: UserStoriesNavigationHandling {
    func openStory(_ story: StoryUIModel) {
        // TODO: Pass the story parameter so that the stories feature opens from a given story onwards, then continues from there
        // No time left for this unfortunately.
        navigationPath.append(.story)
    }
}

// MARK: - StoryNavigationHandling

extension StoryCoordinator: StoryNavigationHandling {
    func closeStories() {
        navigationPath.removeLast()
    }
}
