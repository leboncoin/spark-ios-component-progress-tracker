//
//  ProgressTrackerIntent.swift
//  SparkProgressTracker
//
//  Created by Michael Zimmermann on 11.01.24.
//  Copyright © 2024 Leboncoin. All rights reserved.
//

import Foundation

/// All possible intents of the progress tracker
public enum ProgressTrackerIntent: CaseIterable {
    case accent
    case alert
    case basic
    case danger
    case info
    case main
    case neutral
    case success
    case support
}
