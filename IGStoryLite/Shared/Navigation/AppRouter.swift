//
//  AppRouter.swift
//  IGStoryLite
//
//  Created by TCode on 7/7/25.
//

import SwiftUI

/// An enum representing the high-level navigation routes for the app.
///
/// `AppRoute` is used by the `AppRouter` to determine which major flow should be active:
/// - `.auth`: The authentication flow (e.g., login or registration).
/// - `.main`: The main app content (e.g., after successful login).
enum AppRoute {
    case auth
    case main
}

/// A shared router that controls the root-level navigation of the app.
///
/// `AppRouter` is used in the top-level `App` to decide whether
/// the user should see the authentication flow or the main content flow. It publishes
/// changes to the `route` property, allowing SwiftUI views to respond reactively.
final class AppRouter: ObservableObject {
    /// The current top-level route of the app, determining which flow is presented.
    @Published var route: AppRoute = .main
}
