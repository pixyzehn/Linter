//
//  Template1.swift
//  Linter
//
//  Created by pixyzehn on 2017/05/28.
//
//

import Foundation

class Template1 {
    private init()
    static let shared = Template1()

    func test1(arg1: String, arg2: String, arg3: String) -> (String, String, String) {
        return (arg1, arg2, arg3) // Violate the 'large_tuple` intentionally
    }

    func test2() -> String {
        // Violate the `trailing_semicolon` intentionally
        let test = "HogeHoge";
        // Violate the `trailing_whitespace` intentionally
        return test
    }


    // Violate the `vertical_whitespace` intentionally
}
