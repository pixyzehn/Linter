//
//  CorrectableRule.swift
//  LinterCore
//
//  Created by pixyzehn on 10/8/17.
//

import Foundation

/// The configuration from `swiftlint rules` based on the 0.23.0 version.
enum CorrectableRule: String {
    case closingBrace = "closing_brace"
    case closureSpacing = "closure_spacing"
    case colon
    case comma
    case emptyEnumArguments = "empty_enum_arguments"
    case emptyParameters = "empty_parameters"
    case emptyParenthesesWithTrailingClosure = "empty_parentheses_with_trailing_closure"
    case explicitInit = "explicit_init"
    case implicitReturn = "implicit_return"
    case joinedDefaultParameter = "joined_default_parameter"
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
    case privateOverFileprivate = "private_over_fileprivate"
    case protocolPropertyAccessorsOrder = "protocol_property_accessors_order"
    case redundantDiscardableLet = "redundant_discardable_let"
    case redundantNilCoalescing = "redundant_nil_coalescing"
    case redundantOptionalInitialization = "redundant_optional_initialization"
    case redundantVoidReturn = "redundant_void_return"
    case returnArrowWhitespace = "return_arrow_whitespace"
    case statementPosition = "statement_position"
    case trailingComma = "trailing_comma"
    case trailingNewline = "trailing_newline"
    case trailingSemicolon = "trailing_semicolon"
    case trailingWhitespace = "trailing_whitespace"
    case unneededParenthesesInClosureArgument = "unneeded_parentheses_in_closure_argument"
    case unusedClosureParameter = "unused_closure_parameter"
    case verticalWhitespace = "vertical_whitespace"
    case voidReturn = "void_return"
}
