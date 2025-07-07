//
//  StoryMapper.swift
//  IGStoryLite
//
//  Created by TCode on 7/7/25.
//

import Foundation

enum StoryMapper {
    static let imagesBaseURL = "https://picsum.photos/seed"
    static let storyImagesSizeSuffix = "/800/1400"

    static func map(story: RemoteStory, user: User) -> Story {
        .init(
            id: String(story.id),
            message: story.title,
            createdAt: makeStoryCreationDate(),
            imageURL: makeStoryImageURL(storyID: story.id),
            user: user
        )
    }

    // ⚠️ The field imageURL should be part of the RemoteStory model.
    // However, since the free API I'm using is not returning image URLs, we're mapping images from another API here
    private static func makeStoryImageURL(storyID: Int) -> URL {
        URL(string: "\(imagesBaseURL)/story\(storyID + 31)\(storyImagesSizeSuffix)")!
    }

    // ⚠️ The field createdAt should be part of the RemoteStory model.
    // However, since the free API I'm using is not returning it, I manually add it here for demo purposes
    private static func makeStoryCreationDate() -> Date {
        Date.randomWithinLast(days: 7)
    }
}
