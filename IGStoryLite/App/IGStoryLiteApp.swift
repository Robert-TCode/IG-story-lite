//
//  IGStoryLiteApp.swift
//  IGStoryLite
//
//  Created by TCode on 7/7/25.
//

import SwiftUI

@main
struct IGStoryLiteApp: App {
    @StateObject private var appRouter = AppRouter()
    private let container = AppDIBuilder.start()

    var body: some Scene {
        WindowGroup {
            RootCoordinatorView(container: container)
            .environmentObject(appRouter)
        }
    }
}
