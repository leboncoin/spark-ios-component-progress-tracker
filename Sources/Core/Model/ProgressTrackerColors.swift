//
//  ProgressTrackerColors.swift
//  SparkProgressTracker
//
//  Created by Michael Zimmermann on 11.01.24.
//  Copyright © 2024 Leboncoin. All rights reserved.
//

import SparkTheming

/// A model cotaining the colors of the progress tracker indicator
struct ProgressTrackerColors: Equatable {
    let background: any ColorToken
    let outline: any ColorToken
    let content: any ColorToken

    static func == (lhs: ProgressTrackerColors, rhs: ProgressTrackerColors) -> Bool {
        return lhs.background.equals(rhs.background) &&
        lhs.outline.equals(rhs.outline) &&
        lhs.content.equals(rhs.content)
    }
}
