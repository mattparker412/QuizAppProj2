//
//  XCTestInputValidation.swift
//  QuizAppProj2Tests
//
//  Created by John Figueroa on 3/17/22.
//

import XCTest
@testable import QuizAppProj2
class XCTestInputValidation: XCTestCase {
    let valid = InputValidation()
    func testInputValidation_Returns_true_tfvalid(){
        XCTAssertTrue(valid.validateLoginInput(username: "abc", password: "123"))
    }
    func testInputValidation_Returns_false_tfinvalid(){
        XCTAssertFalse(valid.validateLoginInput(username: "", password: ""))
    }

}
