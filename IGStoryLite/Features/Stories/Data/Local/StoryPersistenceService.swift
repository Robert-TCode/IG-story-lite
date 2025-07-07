//
//  StoryPersistenceService.swift
//  IGStoryLite
//
//  Created by TCode on 7/7/25.
//

protocol StoryPersistenceService {
    func markStoryAsSeen(id: String)
    func markStoryAsLiked(id: String)
    func markStoryAsUnliked(id: String)

    func isStorySeen(id: String) -> Bool
    func isStoryLiked(id: String) -> Bool
}
