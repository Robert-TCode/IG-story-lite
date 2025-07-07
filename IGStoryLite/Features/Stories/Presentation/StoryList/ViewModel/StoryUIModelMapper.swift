//
//  StoryUIModelMapper.swift
//  IGStoryLite
//
//  Created by TCode on 7/7/25.
//

enum StoryUIModelMapper {
    static func map(story: Story) -> StoryUIModel {
        .init(
            id: story.id,
            message: story.message,
            creationDate: story.createdAt.relativeString(),
            imageURL: story.imageURL,
            userImageURL: story.user.avatarURL,
            username: story.user.username,
            isLiked: story.isLiked,
            wasSeen: story.isSeen
        )
    }
}
