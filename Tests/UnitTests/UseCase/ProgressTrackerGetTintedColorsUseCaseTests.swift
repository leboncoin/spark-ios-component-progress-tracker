//
//  ProgressTrackerGetTintedColorsUseCaseTests.swift
//  SparkProgressTrackerUnitTests
//
//  Created by Michael Zimmermann on 18.01.24.
//  Copyright © 2024 Leboncoin. All rights reserved.
//

import XCTest
@testable import SparkProgressTracker
import SparkTheming
@_spi(SI_SPI) import SparkThemingTesting

final class ProgressTrackerGetTintedColorsUseCaseTests: XCTestCase {

    // MARK: Properties
    var sut: ProgressTrackerGetTintedColorsUseCase!
    var colors: ColorsGeneratedMock!

    // MARK: Setup
    override func setUp() {
        super.setUp()

        self.sut = ProgressTrackerGetTintedColorsUseCase()
        self.colors = ColorsGeneratedMock.mocked()
    }

    // MARK: - Tests
    func test_selected_colors() {
        // GIVEN

        for intent in ProgressTrackerIntent.allCases {
            // WHEN
            let colors = self.sut.execute(colors: self.colors, intent: intent, state: .selected)

            // THEN
            XCTAssertEqual(colors, intent.selectedColors(self.colors), "Selected colors for intent \(intent) not as expected")
        }
    }

    func test_enabled_colors() {
        // GIVEN

        for intent in ProgressTrackerIntent.allCases {
            // WHEN

            let colors = self.sut.execute(colors: self.colors, intent: intent, state: .normal)

            // THEN
            XCTAssertEqual(colors, intent.enabledColors(self.colors), "Enabled colors for intent \(intent) not as expected")
        }
    }

    func test_pressed_colors() {
        // GIVEN

        for intent in ProgressTrackerIntent.allCases {
            // WHEN

            let colors = self.sut.execute(colors: self.colors, intent: intent, state: .pressed)

            // THEN
            XCTAssertEqual(colors, intent.pressedColors(self.colors), "Pressed colors for intent \(intent) not as expected")
        }
    }

    func test_colors_disabled() {
        // GIVEN

        for intent in ProgressTrackerIntent.allCases {
            // WHEN

            let colors = self.sut.execute(colors: self.colors, intent: intent, state: .disabled)

            let expectedColors = intent.enabledColors(self.colors)

            // THEN
            XCTAssertEqual(colors, expectedColors, "Disabled colors for intent \(intent) not as expected")
        }
    }
}

// MARK: - Private helpers
private extension ProgressTrackerIntent {

    func selectedColors(_ colors: Colors) -> ProgressTrackerColors {
        let tintedColors: ProgressTrackerTintedColors = {
            switch self {
            case .accent:
                return .init(
                    background: colors.accent.accent,
                    content: colors.accent.onAccent)
            case .alert:
                return .init(
                    background: colors.feedback.alert,
                    content: colors.feedback.onAlert)
            case .basic:
                return .init(
                    background: colors.basic.basic,
                    content: colors.basic.onBasic)
            case .danger:
                return .init(
                    background: colors.feedback.error,
                    content: colors.feedback.onError)
            case .info:
                return .init(
                    background: colors.feedback.info,
                    content: colors.feedback.onInfo)
            case .main:
                return .init(
                    background: colors.main.main,
                    content: colors.main.onMain)
            case .neutral:
                return .init(
                    background: colors.feedback.neutral,
                    content: colors.feedback.onNeutral)
            case .success:
                return .init(
                    background: colors.feedback.success,
                    content: colors.feedback.onSuccess)
            case .support:
                return .init(
                    background: colors.support.support,
                    content: colors.support.onSupport)
            }
        }()

        return ProgressTrackerColors(
            background: tintedColors.background,
            outline: tintedColors.background,
            content: tintedColors.content)
    }

    func enabledColors(_ colors: Colors) -> ProgressTrackerColors {
        let tintedColors: ProgressTrackerTintedColors = {
            switch self {
            case .accent:
                return .init(
                    background: colors.accent.accentContainer,
                    content: colors.accent.onAccentContainer)
            case .alert:
                return .init(
                    background: colors.feedback.alertContainer,
                    content: colors.feedback.onAlertContainer)
            case .basic:
                return .init(
                    background: colors.basic.basicContainer,
                    content: colors.basic.onBasicContainer)
            case .danger:
                return .init(
                    background: colors.feedback.errorContainer,
                    content: colors.feedback.onErrorContainer)
            case .info:
                return .init(
                    background: colors.feedback.infoContainer,
                    content: colors.feedback.onInfoContainer)
            case .main:
                return .init(
                    background: colors.main.mainContainer,
                    content: colors.main.onMainContainer)
            case .neutral:
                return .init(
                    background: colors.feedback.neutralContainer,
                    content: colors.feedback.onNeutralContainer)
            case .success:
                return .init(
                    background: colors.feedback.successContainer,
                    content: colors.feedback.onSuccessContainer)
            case .support:
                return .init(
                    background: colors.support.supportContainer,
                    content: colors.support.onSupportContainer)
            }
        }()

        return ProgressTrackerColors(
            background: tintedColors.background,
            outline: tintedColors.background,
            content: tintedColors.content)
    }

    func pressedColors(_ colors: Colors) -> ProgressTrackerColors {
        let tintedColors: ProgressTrackerTintedColors = {
            switch self {
            case .accent:
                return .init(
                    background: colors.states.accentContainerPressed,
                    content: colors.accent.onAccentContainer)
            case .alert:
                return .init(
                    background: colors.states.alertContainerPressed,
                    content: colors.feedback.onAlertContainer)
            case .basic:
                return .init(
                    background: colors.states.basicContainerPressed,
                    content: colors.basic.onBasicContainer)
            case .danger:
                return .init(
                    background: colors.states.errorContainerPressed,
                    content: colors.feedback.onErrorContainer)
            case .info:
                return .init(
                    background: colors.states.infoContainerPressed,
                    content: colors.feedback.onInfoContainer)
            case .main:
                return .init(
                    background: colors.states.mainContainerPressed,
                    content: colors.main.onMainContainer)
            case .neutral:
                return .init(
                    background: colors.states.neutralContainerPressed,
                    content: colors.feedback.onNeutralContainer)
            case .success:
                return .init(
                    background: colors.states.successContainerPressed,
                    content: colors.feedback.onSuccessContainer)
            case .support:
                return .init(
                    background: colors.states.supportContainerPressed,
                    content: colors.support.onSupportContainer)
            }
        }()

        return ProgressTrackerColors(
            background: tintedColors.background,
            outline: tintedColors.background,
            content: tintedColors.content)
    }
}

