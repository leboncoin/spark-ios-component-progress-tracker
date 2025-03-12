//
//  ProgressTrackerGetVariantColorsUseCaseable.swift
//  SparkProgressTracker
//
//  Created by Michael Zimmermann on 11.01.24.
//  Copyright © 2024 Leboncoin. All rights reserved.
//

import SparkTheming

// sourcery: AutoMockable
protocol ProgressTrackerGetVariantColorsUseCaseable {
    func execute(colors: Colors,
                 intent: ProgressTrackerIntent,
                 state: ProgressTrackerState
    ) -> ProgressTrackerColors
}
