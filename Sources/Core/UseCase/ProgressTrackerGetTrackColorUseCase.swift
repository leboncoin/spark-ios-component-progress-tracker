//
//  ProgressTrackerGetTrackColorUseCase.swift
//  SparkComponentProgressTracker
//
//  Created by Michael Zimmermann on 24.01.24.
//  Copyright © 2024 Leboncoin. All rights reserved.
//

import SparkTheming

// sourcery: AutoMockable
protocol ProgressTrackerGetTrackColorUseCaseable {
    func execute(colors: any Colors,
                 intent: ProgressTrackerIntent) -> any ColorToken
}

/// A use cate returning the color of the `track` between the progress tracker indicators.
struct ProgressTrackerGetTrackColorUseCase: ProgressTrackerGetTrackColorUseCaseable {

    func execute(colors: any Colors,
                 intent: ProgressTrackerIntent) -> any ColorToken {
        switch intent {
        case .basic: return colors.basic.basic
        case .accent: return colors.accent.accent
        case .alert: return colors.feedback.alert
        case .danger: return colors.feedback.error
        case .info: return colors.feedback.info
        case .main: return colors.main.main
        case .neutral: return colors.feedback.neutral
        case .success: return colors.feedback.success
        case .support: return colors.support.support
        }
    }
}
