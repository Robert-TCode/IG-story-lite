//
//  StoryRemoteDataSource.swift
//  IGStoryLite
//
//  Created by TCode on 7/7/25.
//

protocol StoryRemoteDataSource {
    func fetchStories(page: Int, limit: Int) async throws -> [RemoteStory]
}
