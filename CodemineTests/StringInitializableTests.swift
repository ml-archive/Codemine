//
//  StringInitializableTests.swift
//  CodemineTests
//
//  Created by Giorgy Gunawan on 14/10/19.
//  Copyright © 2019 Nodes. All rights reserved.
//

import XCTest
@testable import Codemine

class StringInitializableTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
    }
    
    override func tearDown() {
        super.tearDown()
    }
    
    func testGetStringRepresentableFromURL() {
        let testUrlString = "www.google.com"
        let testUrl = URL.fromString(testUrlString)
        let result = testUrl?.stringRepresentation()
        XCTAssertNotNil(result)
        XCTAssertEqual(result, Optional(testUrlString))
    }
    
    func testGetStringRepresentableFromDate() {
        let testDateString = "1993-11-20T00:00:00+07:00"
        let testDate = Date.fromString(testDateString)
        let result = testDate?.stringRepresentation()
        XCTAssertNotNil(result)
        XCTAssertEqual(result, Optional(testDateString))
    }
    
    func testInitializeDateFromUnsupportedFormat_ShouldReturnNil() {
        let testDateString = "1993ABC-11-20T00:00:00+07:00"
        let result = Date.fromString(testDateString)
        XCTAssertNil(result)
    }
}
