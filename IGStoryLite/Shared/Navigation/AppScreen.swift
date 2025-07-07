//
//  AppScreen.swift
//  IGStoryLite
//
//  Created by TCode on 7/7/25.
//

import SwiftUI

/// A base protocol for all screens used in the app.
///
/// It allows for easier navigation stack identification and management.
/// The `name` property is used for developer-friendly naming and tracking events.
protocol AppScreen: Hashable {
    var name: String { get }
}
