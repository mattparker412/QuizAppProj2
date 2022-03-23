//
//  XCTestSortingAlgorithm.swift
//  QuizAppProj2Tests
//
//  Created by John Figueroa on 3/19/22.
//

import XCTest
@testable import QuizAppProj2
class XCTestSortingAlgorithm: XCTestCase {
    let sortAlgo = SortingAlgorithm()
    func testSortingAlgorithm_returns_void(){
        XCTAssertNoThrow(sortAlgo.sortRanks(numD: [1,0,3,4,9,4,3,2]))
    }
}
