//
//  ProgressTrackerIndependentUITouchHandlerTests.swift
//  SparkProgressTrackerUnitTests
//
//  Created by Michael Zimmermann on 12.02.24.
//  Copyright © 2024 Leboncoin. All rights reserved.
//

import Combine
import XCTest
@testable import SparkProgressTracker
@_spi(SI_SPI) import SparkCommon

final class ProgressTrackerIndependentUITouchHandlerTests: XCTestCase {

    var controls: [UIControl]!

    var sut: ProgressTrackerIndependentUITouchHandler!
    var cancellables = Set<AnyCancellable>()

    // MARK: - Setup
    override func setUp() {
        super.setUp()
        self.controls = (0...4)
            .map { index in
                return CGRect(x: index * 50, y: 0, width: 50, height: 50)
            }
            .map(UIControl.init(frame:))

        let sut = ProgressTrackerInteractionState.independent.touchHandler(currentPageIndex: 0, indicatorViews: self.controls) as? ProgressTrackerIndependentUITouchHandler

        XCTAssertNotNil(sut)

        self.sut = sut
    }

    func test_touch_on_current_page_nothing_happens() {
        // WHEN
        self.sut.beginTracking(location: .zero)

        // THEN
        XCTAssertNil(self.sut.trackingPageIndex)
    }

    func test_touch_on_first_step() {
        // WHEN
        self.sut.beginTracking(location: CGPoint(x: 51, y: 10))

        // THEN
        XCTAssertEqual(self.sut.trackingPageIndex, 1)
    }

    func test_touch_on_second_step() {
        // WHEN
        self.sut.beginTracking(location: CGPoint(x: 101, y: 10))

        // THEN
        XCTAssertEqual(self.sut.trackingPageIndex, 2)
    }

    func test_touch_left_of_current_index() {
        // GIVEN
        self.sut.currentPageIndex = 3

        // WHEN
        self.sut.beginTracking(location: CGPoint(x: 51, y: 10))

        // THEN
        XCTAssertEqual(self.sut.trackingPageIndex, 1)
    }

    func test_touch_right_of_current_index() {
        // GIVEN
        self.sut.currentPageIndex = 3

        // WHEN
        self.sut.beginTracking(location: CGPoint(x: 251, y: 10))

        // THEN
        XCTAssertEqual(self.sut.trackingPageIndex, 4)
    }

    func test_touch_and_move() {
        // GIVEN
        self.sut.beginTracking(location: CGPoint(x: 51, y: 10))

        // WHEN
        self.sut.continueTracking(location: CGPoint(x: 301, y: 10))

        // THEN
        XCTAssertEqual(self.sut.trackingPageIndex, 1)
    }

    func test_touch_and_move_to_current_page() {
        // GIVEN
        self.sut.currentPageIndex = 2
        self.sut.beginTracking(location: CGPoint(x: 51, y: 10))

        // WHEN
        self.sut.continueTracking(location: CGPoint(x: 101, y: 10))

        // THEN
        XCTAssertEqual(self.sut.trackingPageIndex, 1)
    }

    func test_touch_and_move_over_current_page() {
        // GIVEN
        self.sut.currentPageIndex = 2
        self.sut.beginTracking(location: CGPoint(x: 51, y: 10))
        self.sut.continueTracking(location: CGPoint(x: 101, y: 10))

        // WHEN
        self.sut.continueTracking(location: CGPoint(x: 1, y: 10))

        // THEN
        XCTAssertEqual(self.sut.trackingPageIndex, 1)
    }

    func test_value_published_on_end_tracking() {
        // GIVEN
        let expect = expectation(description: "Expect current page to be published")
        self.sut.beginTracking(location: CGPoint(x: 51, y: 10))

        self.sut.currentPagePublisher.subscribe(in: &self.cancellables) { currentPage in
            XCTAssertEqual(currentPage, 1)
            expect.fulfill()
        }
        // WHEN
        self.sut.endTracking(location: CGPoint(x: 251, y: 10))

        // THEN
        wait(for: [expect])

        XCTAssertNil(self.sut.trackingPageIndex)
    }

    func test_value_not_published_on_end_tracking() {
        // GIVEN
        let expect = expectation(description: "Expect current page to be published")
        expect.isInverted = true
        self.sut.beginTracking(location: CGPoint(x: 50, y: 10))

        self.sut.currentPagePublisher.subscribe(in: &self.cancellables) { currentPage in
            XCTFail("Nothing should have been published")
            expect.fulfill()
        }
        // WHEN
        self.sut.endTracking(location: CGPoint(x: 251, y: 10))

        // THEN
        wait(for: [expect], timeout: 0.01)

        XCTAssertEqual(self.sut.currentPageIndex, 0)
        XCTAssertNil(self.sut.trackingPageIndex)
    }

}
