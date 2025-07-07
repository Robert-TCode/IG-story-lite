//
//  MarkStoryAsSeenUseCase.swift
//  IGStoryLite
//
//  Created by TCode on 7/7/25.
//

protocol MarkStoryAsSeenUseCase {
    func execute(storyId: String) async throws
}
