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
    private let persistenceService: StoryPersistenceService

    init(
        storyRemoteDataSource: StoryRemoteDataSource,
        userRemoteDataSource: UserRemoteDataSource,
        persistenceService: StoryPersistenceService
    ) {
        self.storyRemoteDataSource = storyRemoteDataSource
        self.userRemoteDataSource = userRemoteDataSource
        self.persistenceService = persistenceService
    }

    func getStories(page: Int, limit: Int) async throws -> [Story] {
        async let remoteStories = storyRemoteDataSource.fetchStories(page: page, limit: limit)
        async let remoteUsers = userRemoteDataSource.fetchUsers()

        let (stories, users) = try await (remoteStories, remoteUsers)
        let usersDictionary = makeUsersDictionary(users)

        return stories.compactMap { story in
            guard let user = usersDictionary[story.userId] else { return nil }
            return mapAndSetState(remoteStory: story, user: user)
        }
    }

    func updateSeenState(for storyId: String, seen: Bool) {
        // Ideally, here we would make a request to update the remote state of the story, then return the updated object.
        // There's no API for that, so just updating the local state.
        persistenceService.markStoryAsSeen(id: storyId)
    }

    func updateLikedState(for storyId: String, liked: Bool) {
        // Ideally, here we would make a request to update the remote state of the story, then return the updated object.
        // There's no API for that, so just updating the local state.
        if liked {
            persistenceService.markStoryAsLiked(id: storyId)
        } else {
            persistenceService.markStoryAsLiked(id: storyId)
        }
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

    func mapAndSetState(remoteStory: RemoteStory, user: User) -> Story {
        var story = StoryMapper.map(story: remoteStory, user: user)

        story.isSeen = persistenceService.isStorySeen(id: story.id)
        story.isLiked = persistenceService.isStoryLiked(id: story.id)

        return story
    }
}
