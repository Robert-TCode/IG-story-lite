//
//  StoriesDIContainer.swift
//  IGStoryLite
//
//  Created by TCode on 7/7/25.
//

import Foundation

struct StoriesDIContainer {
    @MainActor
    static func register(in container: DIContainer) {
        // Register remote data sources
        container.register(StoryRemoteDataSource.self) {
            StoryRemoteDataSourceImpl(apiClient: container.resolve())
        }

        container.register(UserRemoteDataSource.self) {
            UserRemoteDataSourceImpl(apiClient: container.resolve())
        }

        // Register persistence service
        container.register(StoryPersistenceService.self) {
            StoryPersistenceServiceImpl()
        }

        // Register repository
        container.register(StoryRepository.self) {
            StoryRepositoryImpl(
                storyRemoteDataSource: container.resolve(),
                userRemoteDataSource: container.resolve(),
                persistenceService: container.resolve()
            )
        }

        // Register use cases
        container.register(FetchStoriesUseCase.self) {
            FetchStoriesUseCaseImpl(repository: container.resolve())
        }

        container.register(MarkStoryAsSeenUseCase.self) {
            MarkStoryAsSeenUseCaseImpl(repository: container.resolve())
        }

        container.register(SetLikeStatusUseCase.self) {
            SetLikeStatusUseCaseImpl(repository: container.resolve())
        }
    }
}
