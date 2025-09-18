//
//  ProgressTrackerGetColorsUseCase.swift
//  SparkComponentProgressTracker
//
//  Created by Michael Zimmermann on 11.01.24.
//  Copyright © 2024 Leboncoin. All rights reserved.
//

import SparkTheming

// sourcery: AutoMockable
protocol ProgressTrackerGetColorsUseCaseable {
    func execute(colors: any Colors,
                 intent: ProgressTrackerIntent,
                 state: ProgressTrackerState
    ) -> ProgressTrackerColors
}

/// A use case that returns the color of the progress tracker indicator.
struct ProgressTrackerGetColorsUseCase: ProgressTrackerGetColorsUseCaseable {

    func execute(colors: any Colors,
                 intent: ProgressTrackerIntent,
                 state: ProgressTrackerState
    ) -> ProgressTrackerColors {
        let intentColors: ProgressTrackerTintedColors = {
            if state.isSelected {
                return self.selectedColors(colors: colors, intent: intent)
            } else if state.isPressed {
                return self.pressedColors(colors: colors, intent: intent)
            } else {
                return self.enabledColors(colors: colors, intent: intent)
            }
        }()

        return ProgressTrackerColors(
            background: intentColors.background,
            outline: intentColors.background,
            content: intentColors.content)
    }

    // MARK: - Private functions

    private func pressedColors(colors: any Colors, intent: ProgressTrackerIntent) -> ProgressTrackerTintedColors {
        switch intent {
        case .neutral:
            return .init(
                background: colors.states.neutralContainerPressed,
                content: colors.feedback.onNeutralContainer)
        case .success:
            return .init(
                background: colors.states.successContainerPressed,
                content: colors.feedback.onSuccessContainer)
        default:
            return .init(
                background: colors.states.basicContainerPressed,
                content: colors.basic.onBasicContainer)
        }
    }

    private func selectedColors(colors: any Colors, intent: ProgressTrackerIntent) -> ProgressTrackerTintedColors {
        switch intent {
        case .neutral:
            return .init(
                background: colors.feedback.neutral,
                content: colors.feedback.onNeutral)
        case .success:
            return .init(
                background: colors.feedback.success,
                content: colors.feedback.onSuccess)
        default:
            return .init(
                background: colors.basic.basic,
                content: colors.basic.onBasic)
        }
    }

    private func enabledColors(colors: any Colors, intent: ProgressTrackerIntent) -> ProgressTrackerTintedColors {
        switch intent {
        case .neutral:
            return .init(
                background: colors.feedback.neutralContainer,
                content: colors.feedback.onNeutralContainer)
        case .success:
            return .init(
                background: colors.feedback.successContainer,
                content: colors.feedback.onSuccessContainer)
        default:
            return .init(
                background: colors.basic.basicContainer,
                content: colors.basic.onBasicContainer)
        }
    }
}
