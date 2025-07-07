//
//  Date+Extension.swift
//  IGStoryLite
//
//  Created by TCode on 7/7/25.
//

import Foundation

extension Date {
    /// Generates a random date within the past `numberOfDays` (default is 7).
    static func randomWithinLast(days numberOfDays: Int = 7) -> Date {
        let now = Date()
        let secondsInDay: TimeInterval = 60 * 60 * 24
        let randomInterval = TimeInterval.random(in: 0...(secondsInDay * Double(numberOfDays)))
        return now.addingTimeInterval(-randomInterval)
    }

    func relativeString(to referenceDate: Date = .now, style: RelativeDateTimeFormatter.UnitsStyle = .abbreviated) -> String {
        let formatter = RelativeDateTimeFormatter()
        formatter.unitsStyle = style
        return formatter.localizedString(for: self, relativeTo: referenceDate)
    }
}
