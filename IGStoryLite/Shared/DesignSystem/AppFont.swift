//
//  AppFont.swift
//  IGStoryLite
//
//  Created by TCode on 7/7/25.
//

import SwiftUI

enum AppFont {
    static func body() -> Font {
        .system(size: 16, weight: .regular)
    }

    static func bodyBold() -> Font {
        .system(size: 16, weight: .semibold)
    }

    static func caption() -> Font {
        .system(size: 14, weight: .regular)
    }

    static func title() -> Font {
        .system(size: 20, weight: .bold)
    }
}

