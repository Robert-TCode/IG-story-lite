//
//  StoryPersistenceServiceImpl.swift
//  IGStoryLite
//
//  Created by TCode on 7/7/25.
//

import Foundation

final class StoryPersistenceServiceImpl: StoryPersistenceService {
    private enum Keys {
        static let seenStories = "seen_stories"
        static let likedStories = "liked_stories"
    }

    private var seenStories: Set<String> {
        get { Set(UserDefaults.standard.stringArray(forKey: Keys.seenStories) ?? []) }
        set { UserDefaults.standard.set(Array(newValue), forKey: Keys.seenStories) }
    }

    private var likedStories: Set<String> {
        get { Set(UserDefaults.standard.stringArray(forKey: Keys.likedStories) ?? []) }
        set { UserDefaults.standard.set(Array(newValue), forKey: Keys.likedStories) }
    }

    func markStoryAsSeen(id: String) {
        seenStories.insert(id)
    }

    func markStoryAsLiked(id: String) {
        likedStories.insert(id)
    }

    func markStoryAsUnliked(id: String) {
        likedStories.remove(id)
    }

    func isStorySeen(id: String) -> Bool {
        seenStories.contains(id)
    }

    func isStoryLiked(id: String) -> Bool {
        likedStories.contains(id)
    }
}
