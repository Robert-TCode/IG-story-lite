//
//  User.swift
//  IGStoryLite
//
//  Created by TCode on 7/7/25.
//

import Foundation

struct User: Identifiable, Equatable, Hashable {
    let id: String
    let username: String
    let avatarURL: URL
}
