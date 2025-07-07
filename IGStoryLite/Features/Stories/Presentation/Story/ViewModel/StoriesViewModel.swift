//
//  StoriesViewModel.swift
//  IGStoryLite
//
//  Created by TCode on 7/7/25.
//

import Foundation

@MainActor
final class StoriesViewModel: ObservableObject {
    @Published var stories: [StoryUIModel] = []
    @Published var currentIndex: Int = 0
    @Published var isLastPage = false
    @Published var isLoading = false

    private var currentPage = 0
    private let pageSize = 10

    private let fetchStoriesUseCase: FetchStoriesUseCase
    private let markStoryAsSeenUseCase: MarkStoryAsSeenUseCase
    private let setLikeStatusUseCase: SetLikeStatusUseCase
    private weak var navigator: StoryNavigationHandling?

    init(
        fetchStoriesUseCase: FetchStoriesUseCase,
        markStoryAsSeenUseCase: MarkStoryAsSeenUseCase,
        setLikeStatusUseCase: SetLikeStatusUseCase,
        navigator: StoryNavigationHandling
    ) {
        self.fetchStoriesUseCase = fetchStoriesUseCase
        self.markStoryAsSeenUseCase = markStoryAsSeenUseCase
        self.setLikeStatusUseCase = setLikeStatusUseCase
        self.navigator = navigator
    }

    func loadInitialStories() async {
        stories = []
        currentIndex = 0
        currentPage = 0
        isLastPage = false
        await loadNextPageIfNeeded()
    }

    func onStoryAppear(_ story: StoryUIModel) {
        markStoryAsSeenUseCase.execute(storyId: story.id)

        if let index = stories.firstIndex(where: { $0.id == story.id }) {
            var updated = stories[index]
            updated.wasSeen = true
            stories[index] = updated
        }
    }

    func onCloseButtonTap() {
        navigator?.closeStories()
    }

    func onHeartButtonTap(story: StoryUIModel) {
        setLikeStatusUseCase.execute(storyId: story.id, isLiked: !story.isLiked)

        if let index = stories.firstIndex(where: { $0.id == story.id }) {
            var updated = stories[index]
            updated.isLiked.toggle()
            stories[index] = updated
        }
    }

    func onSendMessageTap(story: StoryUIModel) {
        // TODO: Implement interaction
    }

    func onStoryImageTap() {
        Task {
            await advanceToNextStory()
        }
    }
}

// MARK: - Helpers

private extension StoriesViewModel {
    func advanceToNextStory() async {
        if currentIndex < stories.count - 1 {
            currentIndex += 1
        } else if !isLastPage {
            await loadNextPageIfNeeded()
            if currentIndex < stories.count - 1 {
                currentIndex += 1
            }
        } else {
            navigator?.closeStories()
        }
    }

    func loadNextPageIfNeeded() async {
        guard !isLoading && !isLastPage else { return }

        isLoading = true
        do {
            let newStories = try await fetchStoriesUseCase.execute(page: currentPage, limit: pageSize)

            if newStories.count < pageSize {
                isLastPage = true
            }

            let newStoryModels = newStories.map(mapToUIModel)
            stories.append(contentsOf: newStoryModels)
            currentPage += 1
        } catch {
            // Optionally handle error
        }
        isLoading = false
    }

    func mapToUIModel(story: Story) -> StoryUIModel {
        StoryUIModelMapper.map(story: story)
    }
}
