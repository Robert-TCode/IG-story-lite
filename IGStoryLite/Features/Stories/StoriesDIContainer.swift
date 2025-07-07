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
