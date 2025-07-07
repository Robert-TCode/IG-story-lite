//
//  UserRemoteDataSourceImpl.swift
//  IGStoryLite
//
//  Created by TCode on 7/7/25.
//

import Foundation

final class UserRemoteDataSourceImpl: UserRemoteDataSource {
    private let apiClient: APIClient
    private let baseURL = "https://jsonplaceholder.typicode.com"

    init(apiClient: APIClient) {
        self.apiClient = apiClient
    }

    func fetchUsers() async throws -> [RemoteUser] {
        let usersUrl = URL(string: "\(baseURL)/users")!
        return try await apiClient.get(usersUrl)
    }
}
