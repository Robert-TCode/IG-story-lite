//
//  Story.swift
//  IGStoryLite
//
//  Created by TCode on 7/7/25.
//

import Foundation

struct Story: Identifiable, Equatable, Hashable {
    let id: String
    let message: String
    let createdAt: Date
    let imageURL: URL
    let user: User

    var isSeen: Bool = false
    var isLiked: Bool = false
}
