//
//  XCTestQuizTimer.swift
//  QuizAppProj2Tests
//
//  Created by John Figueroa on 3/17/22.
//

import XCTest
@testable import QuizAppProj2
class XCTestQuizTimer: XCTestCase {

    let clock = Clock()
    func testQuizTimer_Returns_void_printsSeconds(){
        XCTAssertNoThrow(clock.countdownTimer(secondsRemaining: 30))
    }

}
