//
//  AppDIBuilder.swift
//  IGStoryLite
//
//  Created by TCode on 7/7/25.
//

struct AppDIBuilder {
    @MainActor
    static func start() -> DIContainer {
        let container = DIContainer()
        container.registerAppServices()
        return container
    }
}
