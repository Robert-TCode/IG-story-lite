//
//  StoryScreen.swift
//  IGStoryLite
//
//  Created by TCode on 7/7/25.
//

import Foundation

enum StoryScreen: AppScreen {
    case storyList
    case story(Story)

    var name: String {
        switch self {
        case .storyList:
            return "Story List"
        case .story:
            return "Story"
        }
    }
}
