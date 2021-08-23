// swift-tools-version:5.3
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "ISO8601",
    platforms: [.iOS(.v13), .tvOS(.v13), .watchOS(.v6), .macOS(.v10_15)],
    products: [
        .library(name: "ISO8601", targets: ["ISO8601"]),
    ],
    dependencies: [],
    targets: [
        .target(name: "ISO8601", dependencies: []),
        .testTarget(name: "ISO8601Tests", dependencies: ["ISO8601"]),
    ]
)
