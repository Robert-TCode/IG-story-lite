//
//  Coordinator.swift
//  IGStoryLite
//
//  Created by TCode on 7/7/25.
//

import SwiftUI

/// A protocol that defines the navigation behavior for feature-based coordinators in a SwiftUI app.
///
/// `Coordinator` provides a generic interface for managing a navigation stack using a typed array of `Screen` values,
/// enabling strongly typed, programmatic navigation within modular app features.
///
/// Conforming types are expected to manage a `@Published` navigation path and provide logic to
/// navigate backward or return to the root screen.
///
/// This protocol is designed to work seamlessly with SwiftUI's `NavigationStack`, where each coordinator owns
/// a `navigationPath` of screens conforming to `AppScreen`, driving navigation within a specific flow or module.
///
/// ### Example:
/// ```swift
/// enum ProfileScreen: AppScreen {
///     case details
///     case settings
/// }
///
/// final class ProfileCoordinator: Coordinator {
///     @Published var navigationPath = [ProfileScreen]()
/// }
/// ```
///
/// - Note: Conforming types must be `ObservableObject` to allow SwiftUI to observe navigation state using
///   `@StateObject`, `@ObservedObject`, or `@EnvironmentObject`.
protocol Coordinator: ObservableObject {
    associatedtype Screen: AppScreen

    /// A bindable array representing the current navigation stack.
    ///
    /// This path is typically bound to a `NavigationStack` and is mutated to push or pop views.
    var navigationPath: [Screen] { get set }

    /// Pops the most recently pushed screen from the navigation stack.
    ///
    /// This is used to navigate one step back in the flow.
    func pop()

    /// Clears the navigation stack and returns to the root screen.
    ///
    /// This is typically used when the user completes a flow and should return to the start.
    func popToRoot()
}

// MARK: - Explicit common methods implementation

extension Coordinator {
    func pop() {
        guard !navigationPath.isEmpty else { return }
        navigationPath.removeLast()
    }

    func popToRoot() {
        navigationPath.removeLast(navigationPath.count)
    }
}
