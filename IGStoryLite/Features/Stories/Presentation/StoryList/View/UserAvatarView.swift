//
//  UserAvatarView.swift
//  IGStoryLite
//
//  Created by TCode on 7/7/25.
//

import SwiftUI

struct UserAvatarView: View {
    let username: String
    let avatarURL: URL
    let hasNewStory: Bool
    let onTap: () -> Void

    var body: some View {
        VStack(spacing: AppPadding.large) {
            AvatarImage(avatarURL: avatarURL, size: .medium, strokeStyle: hasNewStory ? .accent : .greyedOut)

            Text(username)
                .font(AppFont.caption())
                .lineLimit(1)
        }
        .onTapGesture {
            onTap()
        }
    }
}
