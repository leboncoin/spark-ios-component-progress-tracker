// swift-tools-version: 5.9
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

// swiftlint:disable all
let package = Package(
    name: "SparkProgressTracker",
    platforms: [
        .iOS(.v15)
    ],
    products: [
        .library(
            name: "SparkProgressTracker",
            targets: ["SparkProgressTracker"]
        ),
        .library(
            name: "SparkProgressTrackerTesting",
            targets: ["SparkProgressTrackerTesting"]
        )
    ],
    dependencies: [
       .package(
           url: "https://github.com/adevinta/spark-ios-common.git",
           // path: "../spark-ios-common"
           /*version*/ "0.0.1"..."999.999.999"
       ),
       .package(
           url: "https://github.com/adevinta/spark-ios-theming.git",
           // path: "../spark-ios-theming"
           /*version*/ "0.0.1"..."999.999.999"
       )
    ],
    targets: [
        .target(
            name: "SparkProgressTracker",
            dependencies: [
                .product(
                    name: "SparkCommon",
                    package: "spark-ios-common"
                ),
                .product(
                    name: "SparkTheming",
                    package: "spark-ios-theming"
                )
            ]
        ),
        .target(
            name: "SparkProgressTrackerTesting",
            dependencies: [
                "SparkProgressTracker",
                .product(
                    name: "SparkCommon",
                    package: "spark-ios-common"
                ),
                .product(
                    name: "SparkCommonTesting",
                    package: "spark-ios-common"
                ),
                .product(
                    name: "SparkThemingTesting",
                    package: "spark-ios-theming"
                ),
                .product(
                    name: "SparkTheme",
                    package: "spark-ios-theming"
                )
            ]
        ),
        .testTarget(
            name: "SparkProgressTrackerUnitTests",
            dependencies: [
                "SparkProgressTracker",
                "SparkProgressTrackerTesting",
                .product(
                    name: "SparkCommonTesting",
                    package: "spark-ios-common"
                ),
                .product(
                    name: "SparkThemingTesting",
                    package: "spark-ios-theming"
                )
            ]
        ),
        .testTarget(
            name: "SparkProgressTrackerSnapshotTests",
            dependencies: [
                "SparkProgressTracker",
                "SparkProgressTrackerTesting",
                .product(
                    name: "SparkCommonSnapshotTesting",
                    package: "spark-ios-common"
                ),
            ]
        ),
    ]
)
