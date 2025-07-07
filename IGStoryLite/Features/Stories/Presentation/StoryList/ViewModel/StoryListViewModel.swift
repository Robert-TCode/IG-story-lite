//
//  StoryListViewModel.swift
//  IGStoryLite
//
//  Created by TCode on 7/7/25.
//

import Foundation

@MainActor
final class StoryListViewModel: ObservableObject {
    enum State {
        case loading
        case loaded([StoryUIModel])
        case empty
        case error(String)
    }

    @Published var stories: [StoryUIModel] = []
    @Published var currentIndex: Int = 0
    @Published var isLastPage = false
    @Published var state: State = .loading

    private var currentPage = 0
    private let pageSize = 10

    private let fetchStoriesUseCase: FetchStoriesUseCase
    private weak var navigator: UserStoriesNavigationHandling?

    init(
        fetchStoriesUseCase: FetchStoriesUseCase,
        navigator: UserStoriesNavigationHandling
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

    func didSelect(story: StoryUIModel) {
        navigator?.openStory(story)
    }
}

private extension StoryListViewModel {
    // TODO: Add a call to this method accordingly, triggered by UI when the user approached the end of the currently loaded stories
    // No time for this unfortunately, but an example is done in StoriesViewModel
    func loadNextPageIfNeeded() async {
        guard !isLastPage else { return }

        state = .loading
        do {
            let newStories  = try await fetchStoriesUseCase.execute(page: currentPage, limit: pageSize)

            if newStories.count < pageSize {
                isLastPage = true
            }

            let newStoryModels = newStories.map(mapToUIModel)
            stories.append(contentsOf: newStoryModels)
            currentPage += 1

            if currentPage == 0 {
                state = .empty
            } else {
                state = .loaded(stories)
            }
        } catch {
            state = .error("Failed to load stories. Please try again.")
        }
    }

    func mapToUIModel(story: Story) -> StoryUIModel {
        StoryUIModelMapper.map(story: story)
    }
}
