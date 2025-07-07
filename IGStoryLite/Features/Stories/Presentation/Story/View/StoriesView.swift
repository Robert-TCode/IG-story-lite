//
//  StoriesView.swift
//  IGStoryLite
//
//  Created by TCode on 7/7/25.
//

import SwiftUI

struct StoriesView: View {
    @StateObject private var viewModel: StoriesViewModel

    init(viewModelFactory: @escaping () -> StoriesViewModel) {
        _viewModel = StateObject(wrappedValue: viewModelFactory())
    }

    var body: some View {
        ZStack(alignment: .top) {
            TabView(selection: $viewModel.currentIndex) {
                ForEach(Array(viewModel.stories.enumerated()), id: \.element.id) { index, story in
                    StoryView(
                        storyModel: story,
                        onStoryAppear: { viewModel.onStoryAppear(story) },
                        onClose: viewModel.onCloseButtonTap,
                        onSendMessage: { viewModel.onSendMessageTap(story: story) },
                        onHeartTap: { viewModel.onHeartButtonTap(story: story) },
                        onBackgroundTap: viewModel.onStoryImageTap
                    )
                    .tag(index)
                }
            }
            .tabViewStyle(.page(indexDisplayMode: .never))
            .ignoresSafeArea(edges: .bottom)
        }
        .task {
            await viewModel.loadInitialStories()
        }
        .navigationBarHidden(true)
    }
}
