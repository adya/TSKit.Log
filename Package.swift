// swift-tools-version:5.3
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "TSKit.Log",
    products: [
        .library(
            name: "TSKit.Log",
            targets: ["TSKit.Log"]),
    ],
    dependencies: [
        .package(url: "https://github.com/adya/TSKit.Core.git", .upToNextMajor(from: "2.3.0"))
    ],
    targets: [
        .target(
            name: "TSKit.Log",
            dependencies: ["TSKit.Core"]),
        .testTarget(
            name: "TSKit.LogTests",
            dependencies: ["TSKit.Log"]),
    ]
)
