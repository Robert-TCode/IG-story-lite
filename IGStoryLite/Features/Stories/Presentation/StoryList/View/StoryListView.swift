//
//  StoryListView.swift
//  IGStoryLite
//
//  Created by TCode on 7/7/25.
//

import SwiftUI

struct StoryListView: View {
    @StateObject private var viewModel: StoryListViewModel

    init(viewModelFactory: @escaping () -> StoryListViewModel) {
        _viewModel = StateObject(wrappedValue: viewModelFactory())
    }

    var body: some View {
        Group {
            switch viewModel.state {
            case .loading:
                LoadingIndicatorView()

            case .empty:
                Text("Your friends' stories will appear here.")
                    .font(AppFont.title())
                    .foregroundColor(.secondary)
                    .padding()

            case let .loaded(stories):
                VStack(spacing: AppPadding.large) {
                    ScrollView(.horizontal, showsIndicators: false) {
                        LazyHStack(spacing: AppPadding.large) {
                            ForEach(stories, id: \.id) { story in
                                UserAvatarView(username: story.username, avatarURL: story.userImageURL, hasNewStory: !story.wasSeen)  {
                                    viewModel.didSelect(story: story)
                                }
                            }
                        }
                        .padding(.horizontal, AppPadding.large)
                        .padding(.vertical, AppPadding.medium)
                        .frame(height: 100)
                    }

                    PostsFeedView()
                }

            case .error(let message):
                VStack(spacing: AppPadding.medium) {
                    Text(message)
                        .font(AppFont.body())
                        .foregroundColor(.red)
                    Button("Retry") {
                        Task {
                            await viewModel.loadInitialStories()
                        }
                    }
                    .buttonStyle(.borderedProminent)
                }
            }
        }
        .task {
            await viewModel.loadInitialStories()
        }
    }
}
