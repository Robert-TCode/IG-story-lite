//
//  FetchStoriesUseCase.swift
//  IGStoryLite
//
//  Created by TCode on 7/7/25.
//

protocol FetchStoriesUseCase {
    func execute(page: Int, limit: Int) async throws -> [Story]
}
