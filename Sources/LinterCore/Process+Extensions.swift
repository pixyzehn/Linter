//
//  Process+Extensions.swift
//  LinterCore
//
//  Created by pixyzehn on 10/8/17.
//

import Foundation

extension Process {
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
