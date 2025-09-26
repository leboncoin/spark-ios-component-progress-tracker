//
//  ProgressTrackerGetColorsUseCaseTests.swift
//  SparkComponentProgressTrackerUnitTests
//
//  Created by Michael Zimmermann on 18.01.24.
//  Copyright © 2024 Leboncoin. All rights reserved.
//

import Foundation
import XCTest
@testable import SparkComponentProgressTracker
@_spi(SI_SPI) @testable import SparkComponentProgressTrackerTesting
@_spi(SI_SPI) import SparkThemingTesting
import SparkTheming

final class ProgressTrackerGetColorsUseCaseTests: XCTestCase {

    // MARK: Properties
    var sut: ProgressTrackerGetColorsUseCase!
    var colors: ColorsGeneratedMock!

    // MARK: Setup
    override func setUp() {
        super.setUp()

        self.sut = ProgressTrackerGetColorsUseCase()
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

    func selectedColors(_ colors: any Colors) -> ProgressTrackerColors {
        let tintedColors: ProgressTrackerTintedColors = {
            switch self {
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
        }()

        return ProgressTrackerColors(
            background: tintedColors.background,
            outline: tintedColors.background,
            content: tintedColors.content)
    }

    func enabledColors(_ colors: any Colors) -> ProgressTrackerColors {
        let tintedColors: ProgressTrackerTintedColors = {
            switch self {
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
        }()

        return ProgressTrackerColors(
            background: tintedColors.background,
            outline: tintedColors.background,
            content: tintedColors.content)
    }

    func pressedColors(_ colors: any Colors) -> ProgressTrackerColors {
        let tintedColors: ProgressTrackerTintedColors = {
            switch self {
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
        }()

        return ProgressTrackerColors(
            background: tintedColors.background,
            outline: tintedColors.background,
            content: tintedColors.content)
    }
}

