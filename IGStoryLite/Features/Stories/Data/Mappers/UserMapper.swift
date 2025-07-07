//
//  UserMapper.swift
//  IGStoryLite
//
//  Created by TCode on 7/7/25.
//

import Foundation

enum UserMapper {
    static let imagesBaseURL = "https://picsum.photos/seed"
    static let avatarSizeSuffix = "/100/100"

    static func map(users: [RemoteUser]) -> [User] {
        return users.map { Self.map(user: $0) }
    }

    static func map(user: RemoteUser) -> User {
        .init(
            id: String(user.id),
            username: user.username,
            avatarURL: makeAvatarURL(userID: user.id)
        )
    }

    // ⚠️ The avatarURL should be part of the RemoteUser model.
    // However, since the free API I'm using is not returning image URLs, we're mapping images from another API here
    private static func makeAvatarURL(userID: Int) -> URL {
        URL(string: "\(imagesBaseURL)/user\(userID + 5)\(avatarSizeSuffix)")!
    }
}
