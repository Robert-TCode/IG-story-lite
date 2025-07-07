//
//  MarkStoryAsSeenUseCaseImpl.swift
//  IGStoryLite
//
//  Created by TCode on 7/7/25.
//

import Foundation

final class MarkStoryAsSeenUseCaseImpl: MarkStoryAsSeenUseCase {
    private let repository: StoryRepository

    init(repository: StoryRepository) {
        self.repository = repository
    }

    func execute(storyId: String) {
        repository.updateSeenState(for: storyId, seen: true)
    }
}
