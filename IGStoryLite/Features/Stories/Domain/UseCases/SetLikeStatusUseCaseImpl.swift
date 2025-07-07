//
//  SetLikeStatusUseCaseImpl.swift
//  IGStoryLite
//
//  Created by TCode on 7/7/25.
//

import Foundation

final class SetLikeStatusUseCaseImpl: SetLikeStatusUseCase {
    private let repository: StoryRepository

    init(repository: StoryRepository) {
        self.repository = repository
    }

    func execute(storyId: String, isLiked: Bool) async throws -> Story {
        try await repository.updateLikedState(for: storyId, liked: isLiked)
    }
}
