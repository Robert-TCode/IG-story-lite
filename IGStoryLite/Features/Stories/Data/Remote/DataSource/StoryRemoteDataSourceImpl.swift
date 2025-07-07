//
//  StoryRemoteDataSourceImpl.swift
//  IGStoryLite
//
//  Created by TCode on 7/7/25.
//

import Foundation

final class StoryRemoteDataSourceImpl: StoryRemoteDataSource {
    private let apiClient: APIClient
    private let baseURL = "https://jsonplaceholder.typicode.com"

    init(apiClient: APIClient) {
        self.apiClient = apiClient
    }

    func fetchStories(page: Int, limit: Int) async throws -> [RemoteStory] {
        let storiesUrl = URL(string: "\(baseURL)/posts")!
        let allStories: [RemoteStory] = try await apiClient.get(storiesUrl)
        // The API I'm using doesn't support pagination, so I'm returning the same stories again.
        return allStories
    }
}
