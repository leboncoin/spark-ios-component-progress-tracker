//
//  ProgressTrackerUIControlSnapshotTests.swift
//  SparkProgressTrackerSnapshotTests
//
//  Created by Michael Zimmermann on 12.02.24.
//  Copyright © 2024 Leboncoin. All rights reserved.
//

import XCTest
import SwiftUI
import SnapshotTesting
@_spi(SI_SPI) import SparkCommonSnapshotTesting
import SparkTheming
import SparkTheme

@testable import SparkProgressTracker

final class ProgressTrackerUIViewSnapshotTests: UIKitComponentSnapshotTestCase {

    // MARK: - Properties

    private let theme: Theme = SparkTheme.shared

    // MARK: - Tests

    func test() {
        let scenarios = ProgressTrackerScenarioSnapshotTests.allCases

        for scenario in scenarios {
            let configurations = scenario.configuration(isSwiftUIComponent: false)
            for configuration in configurations {
                let view: ProgressTrackerUIControl

                if configuration.labels.isEmpty {
                    view = ProgressTrackerUIControl(
                        theme: self.theme,
                        intent: configuration.intent,
                        variant: configuration.variant,
                        size: configuration.size,
                        numberOfPages: 5,
                        orientation: configuration.orientation
                    )
                } else {
                    view = ProgressTrackerUIControl(
                        theme: self.theme,
                        intent: configuration.intent,
                        variant: configuration.variant,
                        size: configuration.size,
                        labels: configuration.labels,
                        orientation: configuration.orientation
                    )
                }

                switch configuration.contentType {
                case .icon: view.setPreferredIndicatorImage(UIImage(systemName: "lock.circle"))
                case .text:
                    for i in 0..<5 {
                        view.setIndicatorLabel("A\(i + 1)", forIndex: i)
                    }
                case .empty:
                    view.showDefaultPageNumber = false
                }

                switch configuration.state {
                case .disabled: view.isEnabled = false
                case .selected: view.currentPageIndex = 1
                case .pressed: view.indicatorViews[1].isHighlighted = true
                default: break
                }

                view.backgroundColor = .systemBackground
                view.translatesAutoresizingMaskIntoConstraints = false

                if let frame = configuration.frame {
                    let containerView = UIView(frame: frame)
                    containerView.translatesAutoresizingMaskIntoConstraints = false
                    containerView.widthAnchor.constraint(equalToConstant: frame.width).isActive = true
                    containerView.heightAnchor.constraint(equalToConstant: frame.height).isActive = true
                    containerView.addSubview(view)

                    NSLayoutConstraint.activate([
                        containerView.topAnchor.constraint(equalTo: view.topAnchor),
                        containerView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
                        containerView.bottomAnchor.constraint(greaterThanOrEqualTo: view.bottomAnchor),
                        containerView.trailingAnchor.constraint(equalTo: view.trailingAnchor)
                    ])

                    self.assertSnapshot(
                        matching: containerView,
                        modes: configuration.modes,
                        sizes: configuration.sizes,
                        testName: configuration.testName()
                    )
                } else {
                    self.assertSnapshot(
                        matching: view,
                        modes: configuration.modes,
                        sizes: configuration.sizes,
                        testName: configuration.testName()
                    )
                }

            }
        }
    }
}
