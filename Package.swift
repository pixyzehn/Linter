// swift-tools-version:5.1

import PackageDescription

let package = Package(
    name: "Linter",
    dependencies: [
        .package(url: "https://github.com/JohnSundell/Files.git", from: "4.0.2")
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
