// swift-tools-version:4.2
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "Linter",
    dependencies: [
        .package(url: "https://github.com/JohnSundell/Files.git", from: "3.1.0")
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
