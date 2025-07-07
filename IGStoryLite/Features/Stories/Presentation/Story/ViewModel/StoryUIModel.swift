//
//  StoryUIModel.swift
//  IGStoryLite
//
//  Created by TCode on 7/7/25.
//

import Foundation

struct StoryUIModel: Identifiable {
    var id: String
    var message: String
    var creationDate: String
    var imageURL: URL
    var userImageURL: URL
    var username: String
    var isLiked: Bool
    var wasSeen: Bool
}
