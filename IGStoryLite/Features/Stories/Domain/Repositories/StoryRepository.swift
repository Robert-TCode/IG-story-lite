//
//  StoryRepository.swift
//  IGStoryLite
//
//  Created by TCode on 7/7/25.
//

protocol StoryRepository {
    func getStories(page: Int, limit: Int) async throws -> [Story]
    func updateSeenState(for storyId: String, seen: Bool) async throws -> Story
    func updateLikedState(for storyId: String, liked: Bool) async throws -> Story
}
