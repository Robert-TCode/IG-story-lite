//
//  DIContainer.swift
//  IGStoryLite
//
//  Created by TCode on 7/7/25.
//

import SwiftUI

@MainActor
final class DIContainer: ObservableObject {
    private var services: [ObjectIdentifier: () -> Any] = [:]
    private var singletons: [ObjectIdentifier: Any] = [:]

    // MARK: - Register

    /// Registers a factory for a given type.
    func register<T>(_ type: T.Type, factory: @escaping () -> T) {
        services[ObjectIdentifier(type)] = factory
    }

    /// Registers an already-constructed singleton instance.
    func registerSingleton<T>(_ type: T.Type, instance: T) {
        singletons[ObjectIdentifier(type)] = instance
    }

    // MARK: - Resolve

    func resolve<T>(_ type: T.Type = T.self) -> T {
        let key = ObjectIdentifier(type)

        if let instance = singletons[key] as? T {
            return instance
        }

        guard let factory = services[key], let result = factory() as? T else {
            fatalError("No registered service for type: \(type)")
        }

        return result
    }

    // MARK: - App-Specific Registration

    func registerAppServices() {
        // 🔁 Shared singleton dependencies
        let apiClient = URLSessionAPIClient()
        registerSingleton(APIClient.self, instance: apiClient)

        // 🔁 Feature-specific registration
        StoriesDIContainer.register(in: self)
    }
}
