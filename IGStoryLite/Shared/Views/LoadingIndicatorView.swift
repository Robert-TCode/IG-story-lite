//
//  LoadingIndicatorView.swift
//  IGStoryLite
//
//  Created by TCode on 7/7/25.
//

import SwiftUI

struct LoadingIndicatorView: View {
    var body: some View {
        ProgressView()
            .progressViewStyle(CircularProgressViewStyle())
            .scaleEffect(1.4)
            .padding(.bottom, AppPadding.xLarge)
    }
}
