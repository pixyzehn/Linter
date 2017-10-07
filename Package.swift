// swift-tools-version:4.0
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "Linter",
    dependencies: [
        .package(url: "https://github.com/pixyzehn/Files.git", from: "1.13.0")
    ],
    targets: [
        .target(
            name: "Linter",
            dependencies: ["LinterCore"]),
        .target(
            name: "LinterCore",
            dependencies: ["Files"]),
        .testTarget(
            name: "LinterTests",
            dependencies: ["LinterCore"])
    ]
)
