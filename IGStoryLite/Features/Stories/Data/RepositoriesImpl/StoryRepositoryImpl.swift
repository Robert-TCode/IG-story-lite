//
//  StoryRepositoryImpl.swift
//  IGStoryLite
//
//  Created by TCode on 7/7/25.
//

enum StoryError: Error {
    case notImplementedYet
}

final class StoryRepositoryImpl: StoryRepository {
    private let storyRemoteDataSource: StoryRemoteDataSource
    private let userRemoteDataSource: UserRemoteDataSource

    init(
        storyRemoteDataSource: StoryRemoteDataSource,
        userRemoteDataSource: UserRemoteDataSource
    ) {
        self.storyRemoteDataSource = storyRemoteDataSource
        self.userRemoteDataSource = userRemoteDataSource
    }

    func getStories(page: Int, limit: Int) async throws -> [Story] {
        async let remoteStories = storyRemoteDataSource.fetchStories(page: page, limit: limit)
        async let remoteUsers = userRemoteDataSource.fetchUsers()

        let (stories, users) = try await (remoteStories, remoteUsers)
        let usersDictionary = makeUsersDictionary(users)

        return stories.compactMap { story in
            guard let user = usersDictionary[story.userId] else { return nil }
            return StoryMapper.map(story: story, user: user)
        }
    }

    func updateSeenState(for storyId: String, seen: Bool) async throws -> Story {
        throw StoryError.notImplementedYet
    }

    func updateLikedState(for storyId: String, liked: Bool) async throws -> Story {
        throw StoryError.notImplementedYet
    }
}

// MARK: - Helpers

private extension StoryRepositoryImpl {
    // ⚠️ Note: The user should be part of the RemoteStory model.
    // Since the API I'm using doesn't return data that way, I'm mapping users to stories manually for demo purposes.
    func makeUsersDictionary(_ users: [RemoteUser]) -> Dictionary<Int, User> {
        Dictionary(uniqueKeysWithValues: users.map {
            ($0.id, UserMapper.map(user: $0))
        })
    }
}
