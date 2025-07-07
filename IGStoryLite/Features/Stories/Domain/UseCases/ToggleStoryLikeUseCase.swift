//
//  ToggleStoryLikeUseCase.swift
//  IGStoryLite
//
//  Created by TCode on 7/7/25.
//

protocol ToggleStoryLikeUseCase {
    func execute(storyId: String) async throws -> Story
}
