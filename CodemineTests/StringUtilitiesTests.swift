//
//  StringUtilitiesTests.swift
//  CodemineTests
//
//  Created by Style Theory on 14/10/19.
//  Copyright © 2019 Nodes. All rights reserved.
//

import XCTest

class StringUtilitiesTests: XCTestCase {

    override func setUp() {
        super.setUp()
    }

    override func tearDown() {
        super.tearDown()
    }

    func testTrimString() {
        let testString = "hi    there   bear"
        let result = testString.trimSpacing()
        let expectedResult = "hitherebear"
        XCTAssertEqual(result, expectedResult)
    }

}
