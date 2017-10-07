/**
 *  Linter
 *  Copyright (c) Nagasawa Hiroki 2017
 *  Licensed under the MIT license. See LICENSE file.
 */

import PackageDescription

let package = Package(
    name: "Linter",
    targets: [
        Target(
            name: "Linter",
            dependencies: ["LinterCore"]
        ),
        Target(name: "LinterCore")
    ],
    dependencies: [
        .Package(url: "https://github.com/pixyzehn/Files.git", majorVersion: 1)
    ]
)
