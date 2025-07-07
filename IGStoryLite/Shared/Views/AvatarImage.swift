//
//  AvatarImage.swift
//  IGStoryLite
//
//  Created by TCode on 7/7/25.
//

import SwiftUI

struct AvatarImage: View {
    enum Size {
        case small
        case medium

        var length: CGFloat {
            switch self {
            case .small:
                return 36
            case .medium:
                return 64
            }
        }
    }

    enum StrokeStyle {
        case accent
        case greyedOut

        var color: Color {
            switch self {
            case .accent:
                return Color.orange.opacity(0.6)
            case .greyedOut:
                return Color.black.opacity(0.3)
            }
        }
    }

    private let avatarURL: URL
    private let size: Size
    private let strokeStyle: StrokeStyle

    init(avatarURL: URL, size: Size = .medium, strokeStyle: StrokeStyle) {
        self.avatarURL = avatarURL
        self.size = size
        self.strokeStyle = strokeStyle
    }

    var body: some View {
        AsyncImage(url: avatarURL) { phase in
            switch phase {
            case .success(let image):
                image
                    .resizable()
                    .scaledToFill()
            case .failure:
                Image(systemName: "person.crop.circle.fill")
                    .resizable()
            default:
                EmptyView()
            }
        }
        .frame(width: size.length, height: size.length)
        .clipShape(Circle())
        .overlay(
            Circle()
                .stroke(strokeStyle.color, lineWidth: 2)
        )
    }
}
