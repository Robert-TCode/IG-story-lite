//
//  UserRemoteDataSource.swift
//  IGStoryLite
//
//  Created by TCode on 7/7/25.
//

protocol UserRemoteDataSource {
    func fetchUsers() async throws -> [RemoteUser]
}
