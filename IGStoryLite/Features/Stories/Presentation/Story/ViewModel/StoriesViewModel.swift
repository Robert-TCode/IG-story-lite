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
    private weak var navigator: StoryNavigationHandling?

    init(
        fetchStoriesUseCase: FetchStoriesUseCase,
        navigator: StoryNavigationHandling
    ) {
        self.fetchStoriesUseCase = fetchStoriesUseCase
        self.navigator = navigator
    }

    func loadInitialStories() async {
        stories = []
        currentIndex = 0
        currentPage = 0
        isLastPage = false
        await loadNextPageIfNeeded()
    }

    func onCloseButtonTap() {
        // TODO
    }

    func onHeartButtonTap(story: StoryUIModel) {
        // TODO
    }

    func onSendMessageTap(story: StoryUIModel) {
        // TODO
    }

    func onStoryImageTap() {
        // TODO
    }
}

// MARK: - Helpers

private extension StoriesViewModel {
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
