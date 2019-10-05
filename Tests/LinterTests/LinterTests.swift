/**
 *  Linter
 *  Copyright (c) Nagasawa Hiroki 2017
 *  Licensed under the MIT license. See LICENSE file.
 */

import XCTest
import LinterCore
import Files

class LinterTests: XCTestCase {
    private var file: File!
    let tmpFileName = ".temp.yml"
    let fileName = ".swiftlint.yml"

    override func setUp() {
        super.setUp()
        // Rename `.swiftlint.yml` to `.swiftlint-temp.yml` for tests.
        if let file = try? Folder.current.file(named: fileName) {
            self.file = file
            try? self.file.rename(to: tmpFileName)
        }
    }

    override func tearDown() {
        super.tearDown()
        // Delete the fake `.swiftlint.yml`.
        try? Folder.current.file(named: fileName).delete()

        // Rename `.swiftlint-tmp.yml` to `.swiftlint.yml`.
        if let file = try? Folder.current.file(named: tmpFileName) {
            try? file.rename(to: fileName)
        }
    }

    func testCreatingYamlForSwiftLint() throws {
        try Linter(arguments: ["linter", "--included", "Templates"]).run()

        let file = try Folder.current.file(named: fileName)
        let content = try file.readAsString()

        XCTAssertTrue(content.contains("disabled_rules:"))
        XCTAssertTrue(content.contains("- trailing_semicolon # (1) Correctable (you can use `swiftlint autocorrect` to fix)"))
        XCTAssertTrue(content.contains("- large_tuple # (1)"))
        XCTAssertTrue(content.contains("- type_name # (1)"))
        XCTAssertTrue(content.contains("- vertical_whitespace # (1) Correctable (you can use `swiftlint autocorrect` to fix)"))
        XCTAssertTrue(content.contains("- colon # (1) Correctable (you can use `swiftlint autocorrect` to fix)"))
        XCTAssertTrue(content.contains("- void_return # (1) Correctable (you can use `swiftlint autocorrect` to fix)"))

        XCTAssertTrue(content.contains("included:"))
        XCTAssertTrue(content.contains("- Templates"))
    }

    func testIncludedAndExcludedOptions() throws {
        try Linter(arguments: ["linter", "--included", "Main", "MainTests", "--excluded", "Pods", "Carthage"]).run()

        let file = try Folder.current.file(named: fileName)
        let content = try file.readAsString()

        XCTAssertTrue(content.contains("included:\n  - Main\n  - MainTests"))
        XCTAssertTrue(content.contains("excluded:\n  - Pods\n  - Carthage"))
    }
}

extension LinterTests {
    static var allTests: [(String, (LinterTests) -> () throws -> Void)] {
        return [
            ("testCreatingYamlForSwiftLint", testCreatingYamlForSwiftLint)
        ]
    }
}
