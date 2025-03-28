//
//  ProgressTrackerAccessibilityIdentifier.swift
//  SparkProgressTracker
//
//  Created by Michael Zimmermann on 09.02.24.
//  Copyright © 2024 Leboncoin. All rights reserved.
//

import Foundation

/// The accessibility identifiers for the Progress Tracker
public enum ProgressTrackerAccessibilityIdentifier {

    /// The general identifier for the control
    public static let identifier = "spark-progress-tracker"

    public static let indicator = "\(Self.identifier)-indicator"

    public static let label = "\(Self.identifier)-label"

    public static func indicator(forIndex index: Int) -> String {
        return "\(Self.indicator)-\(index)"
    }

    public static func label(forIndex index: Int) -> String {
        return "\(Self.label)-\(index)"
    }
}
