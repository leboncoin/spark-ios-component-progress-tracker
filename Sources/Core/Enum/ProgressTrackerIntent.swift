//
//  ProgressTrackerIntent.swift
//  SparkComponentProgressTracker
//
//  Created by Michael Zimmermann on 11.01.24.
//  Copyright © 2024 Leboncoin. All rights reserved.
//

import Foundation

/// All possible intents of the progress tracker
public enum ProgressTrackerIntent: CaseIterable {
    case basic
    case neutral
    case success

    @available(*, deprecated, message: "Use basic, neutral or success instead.")
    case accent
    @available(*, deprecated, message: "Use basic, neutral or success instead.")
    case alert
    @available(*, deprecated, message: "Use basic, neutral or success instead.")
    case danger
    @available(*, deprecated, message: "Use basic, neutral or success instead.")
    case info
    @available(*, deprecated, message: "Use basic, neutral or success instead.")
    case main
    @available(*, deprecated, message: "Use basic, neutral or success instead.")
    case support

    // MARK: - Properties

    static public var allCases: [Self] = [
        .basic,
        .neutral,
        .success
    ]
}
