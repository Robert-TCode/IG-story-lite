//
//  StoryView.swift
//  IGStoryLite
//
//  Created by TCode on 7/7/25.
//

import SwiftUI

struct StoryView: View {
    let storyModel: StoryUIModel
    let onClose: () -> Void
    let onSendMessage: () -> Void
    let onHeartTap: () -> Void
    let onBackgroundTap: () -> Void

    var body: some View {
        VStack(spacing: AppPadding.large) {
            ZStack {
                tappableBackgroundImage()
                overlays()
            }
            .aspectRatio(9/16, contentMode: .fit)
            .cornerRadius(12)
            .clipped()
            .padding(.horizontal, AppPadding.medium)

            messageBar()
                .padding(.top, AppPadding.large)
                .padding(.horizontal, AppPadding.medium)
        }
    }

    // MARK: - Background Image with Tap

    @ViewBuilder
    private func tappableBackgroundImage() -> some View {
        GeometryReader { geometry in
            backgroundImage()
                .frame(width: geometry.size.width, height: geometry.size.height)
                .contentShape(Rectangle())
                .onTapGesture {
                    onBackgroundTap()
                }
        }
    }

    // MARK: - Raw Background Image (reused)

    private func backgroundImage() -> some View {
        AsyncImage(url: storyModel.imageURL) { phase in
            switch phase {
            case .empty:
                ZStack {
                    AppColor.placeholderBackground
                    LoadingIndicatorView()
                }

            case .success(let image):
                image
                    .resizable()
                    .scaledToFill()
                    .transition(.opacity)
                    .animation(.easeInOut(duration: 0.3), value: UUID())

            case .failure:
                ZStack {
                    AppColor.placeholderBackground
                    Image(systemName: "exclamationmark.triangle")
                        .foregroundColor(.red)
                }

            @unknown default:
                EmptyView()
            }
        }
    }

    // MARK: - Overlays

    @ViewBuilder
    private func overlays() -> some View {
        VStack {
            topBar()
                .padding([.top, .horizontal], AppPadding.xLarge)

            Spacer()

            if !storyModel.message.isEmpty {
                Text(storyModel.message)
                    .font(AppFont.bodyBold())
                    .foregroundColor(AppColor.textPrimary)
                    .lineLimit(2)
                    .shadow(radius: 2)
                    .padding(.horizontal, AppPadding.large)
                    .padding(.bottom, AppPadding.xLarge)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .background(
                        LinearGradient(
                            gradient: Gradient(colors: [AppColor.overlayBackground, .clear]),
                            startPoint: .bottom,
                            endPoint: .top
                        )
                    )
            }
        }
    }

    // MARK: - Top Bar

    private func topBar() -> some View {
        HStack(spacing: AppPadding.large) {
            AvatarImage(avatarURL: storyModel.userImageURL, size: .small, strokeStyle: storyModel.wasSeen ? .greyedOut : .accent)
                .shadow(radius: 2)

            VStack(alignment: .leading, spacing: 2) {
                Text(storyModel.username)
                    .font(AppFont.bodyBold())
                    .foregroundColor(AppColor.textPrimary)

                Text(storyModel.creationDate)
                    .font(AppFont.caption())
                    .foregroundColor(AppColor.textSecondary)
            }

            Spacer()

            Button(action: onClose) {
                Image(systemName: "xmark")
                    .foregroundColor(AppColor.textPrimary)
                    .padding(8)
            }
        }
    }

    // MARK: - Message Bar

    private func messageBar() -> some View {
        HStack {
            Button(action: onSendMessage) {
                Text("Send message…")
                    .foregroundColor(AppColor.textSecondary)
                    .font(AppFont.body())
                    .padding(.vertical, 10)
                    .padding(.horizontal)
                    .background(AppColor.accent)
                    .clipShape(Capsule())
            }
            .buttonStyle(.plain)

            Spacer()

            Button(action: onHeartTap) {
                Image(systemName: storyModel.isLiked ? "heart.fill" : "heart")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 28, height: 28)
                    .foregroundColor(AppColor.accent)
                    .padding(AppPadding.small)
            }
            .buttonStyle(.plain)
        }
        .padding(.bottom, AppPadding.xLarge)
    }
}

struct StoryView_Previews: PreviewProvider {
    static var previews: some View {
        StoryView(
            storyModel: StoryUIModel.mock,
            onClose: {},
            onSendMessage: {},
            onHeartTap: {},
            onBackgroundTap: {}
        )
    }
}

private extension StoryUIModel {
    static let mock = StoryUIModel(
        id: "story1",
        message: "This is a mock story message.",
        creationDate: "4h ago",
        imageURL: URL(string: "https://picsum.photos/seed/story32/800/1400")!,
        userImageURL: URL(string: "https://picsum.photos/seed/user7/100/100")!,
        username: "roberttcode",
        isLiked: false,
        wasSeen: false
    )
}

private extension Story {
    static let mock = Story(
        id: "story1",
        message: "This is a mock story message.",
        createdAt: Date(),
        imageURL: URL(string: "https://picsum.photos/seed/story32/800/1400")!,
        user: .mock
    )
}

private extension User {
    static let mock = User(
        id: "user1",
        username: "mock_user",
        avatarURL: URL(string: "https://picsum.photos/seed/user7/100/100")!
    )
}
