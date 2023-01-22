// swift-tools-version: 5.7
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "NetHub",
    platforms: [
        .macOS(.v10_15), .iOS(.v15)
    ],
    products: [
        .library(name: "NetHub", targets: ["NetHub"]),
    ],
    dependencies: [
//        .package(url: "https://github.com/realm/SwiftLint.git", from: "0.50.0")
    ],
    targets: [
        .target(
            name: "NetHub",
            dependencies: []
//            plugins: [.plugin(name: "SwiftLintPlugin", package: "SwiftLint")]
        ),
        .testTarget(
            name: "NetHubTests",
            dependencies: ["NetHub"]
//            plugins: [.plugin(name: "SwiftLintPlugin", package: "SwiftLint")]
        ),
    ]
)
