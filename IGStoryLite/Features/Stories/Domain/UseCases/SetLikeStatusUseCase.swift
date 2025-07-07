//
//  SetLikeStatusUseCase.swift
//  IGStoryLite
//
//  Created by TCode on 7/7/25.
//

protocol SetLikeStatusUseCase {
    func execute(storyId: String, isLiked: Bool) async throws -> Story
}
