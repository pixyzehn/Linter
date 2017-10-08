/**
 *  Linter
 *  Copyright (c) Nagasawa Hiroki 2017
 *  Licensed under the MIT license. See LICENSE file.
 */

import Foundation
import Files

public final class Linter {
    private let arguments: [String]

    public init(arguments: [String] = CommandLine.arguments) {
        self.arguments = arguments
    }

    private let fileManager = FileManager.default
    private let fileName = ".swiftlint.yml"
    private var file: File!

    /// The configuration from `swiftlint rules` based on the 0.19.0 version.
    private enum CorrectableRule: String {
        case closingBrace = "closing_brace"
        case colon
        case comma
        case emptyParameters = "empty_parameters"
        case emptyParenthesesWithTrailingClosure = "empty_parentheses_with_trailing_closure"
        case explicitInit = "explicit_init"
        case leadingWhitespace = "leading_whitespace"
        case legacyCggeometryFunctions = "legacy_cggeometry_functions"
        case legacyConstant = "legacy_constant"
        case legacyConstructor = "legacy_constructor"
        case legacyNsgeometryFunctions = "legacy_nsgeometry_functions"
        case mark
        case nimbleOperator = "nimble_operator"
        case numberSeparator = "number_separator"
        case openingBrace = "opening_brace"
        case operatorUsageWhitespace = "operator_usage_whitespace"
        case redundantDiscardableLet = "redundant_discardable_let"
        case redundantNilCoalescing = "redundant_nil_coalescing"
        case redundantOptionalInitialization = "redundant_optional_initialization"
        case redundantVoidReturn = "redundant_void_return"
        case returnArrowWhitespace = "return_arrow_whitespace"
        case statementPosition = "statement_position"
        case trailingNewline = "trailing_newline"
        case trailingSemicolon = "trailing_semicolon"
        case trailingWhitespace = "trailing_whitespace"
        case unusedClosureParameter = "unused_closure_parameter"
        case verticalWhitespace = "verticalWhitespace"
        case voidReturn = "void_return"
    }

    public func run() throws {
        if arguments.count == 2 && arguments.contains("help") {
            printDescription()
            return
        }
        let folder = FileSystem().currentFolder

        print("Deleting `.swiftlint.yml` file if needed...")
        try? folder.file(named: fileName).delete()

        print("Creating a new `.swiftlint.yml` file...")
        file = try folder.createFile(named: fileName)

        addIncludedOrExcludedIfNeeded(arguments: arguments)

        print("Executing `swiftlint`in \(folder.path)...")
        let result = try Process().launchBash(with: "swiftlint")
        let outputs = result.components(separatedBy: "\n")

        let (warningCount, errorCount, identifiers) = extractIdentifiers(outputs: outputs)

        showSummary(warningCount: warningCount, errorCount: errorCount, identifiers: identifiers)
        print("Updated `.swiftlint.yml` based on initial warnings and errors")
    }

    // MARK: Private method

    private func printDescription() {
        print("Linter")
        print("   help: Display general or command-specific help.")
        print("   --included: Paths to include during linting and add to `.swiftlint.yml` as `included:`.")
        print("   --excluded: Paths to ignore during linting and add to `.swiftlint.yml` as `excluded:`.")
    }

    private func addIncludedOrExcludedIfNeeded(arguments: [String]) {
        var expectingIncluded = false
        var expectingExcluded = false
        var includedPaths: [String] = []
        var excludedPaths: [String] = []

        for argument in arguments[1..<arguments.count] {
            if expectingIncluded && !argument.hasPrefix("--") {
                includedPaths.append(argument)
            }

            if expectingExcluded && !argument.hasPrefix("--") {
                excludedPaths.append(argument)
            }

            switch argument {
            case "--included":
                expectingIncluded = true
                expectingExcluded = false
            case "--excluded":
                expectingIncluded = false
                expectingExcluded = true
            default:
                continue
            }
        }

        var content = ""

        // Update for `included:`
        if !includedPaths.isEmpty {
            content += "included:\n"
            for path in includedPaths {
                content += "  - \(path)\n"
            }
            print("Adding `included` section...")
        }

        // Update for `excluded:`
        if !excludedPaths.isEmpty {
            if !content.isEmpty {
                content += "\n"
            }
            content += "excluded:\n"
            for path in excludedPaths {
                content += "  - \(path)\n"
            }
            print("Adding `excluded` section...")
        }

        try? file.write(string: content, encoding: .utf8)
    }

    private func extractIdentifiers(outputs: [String]) -> (Int, Int, [String: Int]) {
        var warningCount = 0
        var errorCount = 0
        var identifiersWithCount = [String: Int]()

        print("Extracting the identifier of warnings and errors...")
        for output in outputs {
            if output.contains("warning") {
                warningCount += 1
            } else if output.contains("error") {
                errorCount += 1
            } else {
                print("No error & warning 🎉")
                return (warningCount, errorCount, [:])
            }

            // Assume the following output
            // ***.swift:55: warning: Trailing Whitespace Violation: Lines should not have trailing whitespace. (trailing_whitespace)
            let typePattern = "\\([a-z_]+\\)"
            if let typeRange = output.range(of: typePattern,
                                       options: .regularExpression) {
                let result = output[typeRange]
                let startIndex = result.index(after: result.startIndex)
                let endIndex = result.index(before: result.endIndex)

                let identifier = String(result[startIndex..<endIndex])
                identifiersWithCount[identifier, default: 0] += 1
            }
        }

        return (warningCount, errorCount, identifiersWithCount)
    }

    private func showSummary(warningCount: Int, errorCount: Int, identifiers: [String: Int]) {
        print("----------------------------------")
        print("Summary")
        print("Warning count: \(warningCount)")
        print("Error count  : \(errorCount)\n")

        if !identifiers.isEmpty {
            var content = "disabled_rules:\n"

            for (identifier, count) in identifiers {
                var onelineContent = "  - \(identifier) # (\(count)) "
                if CorrectableRule(rawValue: identifier) != nil {
                    onelineContent += "Correctable (you can use `swiftlint autocorrect` to fix)"
                }
                print(onelineContent)
                onelineContent += "\n"
                content += onelineContent
            }

            try? file.write(string: content + "\n" + (try file.readAsString()), encoding: .utf8)
        }
        print("----------------------------------")
    }
}

private extension Process {
    @discardableResult func launchBash(with command: String) throws -> String {
        launchPath = "/bin/bash"
        arguments = ["-c", command]

        let outputPipe = Pipe()
        standardOutput = outputPipe

        launch()

        let output = outputPipe.read() ?? ""

        waitUntilExit()

        return output
    }
}

private extension Pipe {
    func read() -> String? {
        let data = fileHandleForReading.readDataToEndOfFile()

        guard let output = String(data: data, encoding: .utf8) else {
            return nil
        }

        guard !output.hasSuffix("\n") else {
            let outputLength = output.distance(from: output.startIndex, to: output.endIndex)
            return String(output[..<output.index(output.startIndex, offsetBy: outputLength - 1)])
        }

        return output
    }
}
