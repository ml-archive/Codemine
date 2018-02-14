//
//  URLParameterTests.swift
//  Codemine
//
//  Created by Peter Bødskov on 24/08/2017.
//  Copyright © 2017 Nodes. All rights reserved.
//

import XCTest

class URLParameterTests: XCTestCase {
    
    func testCanFindURLParameter() {
        guard let url = URL(string: "https://example.com?param1=value1&param2=value2") else {
            XCTFail("could not create URL")
            return
        }
        
        let expectedValue1 = "value1"
        guard let actualValue1 = url.value(forParameter: "param1") else {
            XCTFail("no value found for parameter")
            return
        }
        XCTAssertTrue(expectedValue1 == actualValue1)
        
        let expectedValue2 = "value2"
        guard let actualValue2 = url.value(forParameter: "param2") else {
            XCTFail("no value found for parameter")
            return
        }
        XCTAssertTrue(expectedValue2 == actualValue2)
    }
    
    func testReturnsFirstParameterOfMultipleParametersWithSameName() {
        //URL with multiple parameters having the same name but different values (no it shouldn't happen but...)
        guard let url = URL(string: "https://example.com?param1=value1&param1=value2") else {
            XCTFail("could not create URL")
            return
        }
        let expectedValue = "value1"
        guard let actualValue = url.value(forParameter: "param1") else {
            XCTFail("no value found for parameter")
            return
        }
        XCTAssertTrue(expectedValue == actualValue)
    }
    
    func testCanReturnNilForInvalidCases() {
        guard let url = URL(string: "https://example.com?param1=value1&param2=value2") else {
            XCTFail("could not create URL")
            return
        }
        XCTAssertNil(url.value(forParameter: "nothere"))
        
        guard let urlWithNoParameters = URL(string: "https://example.com") else {
            XCTFail("could not create URL")
            return
        }
        XCTAssertNil(urlWithNoParameters.value(forParameter: "nothere"))
        
    }
    
    func testCanReturnValueFromURLWithTwoParametersWithTheSameName() {
        guard let urlWithTwoParametersWithSameName = URL(string: "https://example.com?param1=value1&param2=value2&param1=value3") else {
            XCTFail("could not create URL")
            return
        }
        
        let expectedValue = "value1"
        guard let actualValue = urlWithTwoParametersWithSameName.value(forParameter: "param1") else {
            XCTFail("no value found for parameter")
            return
        }
        XCTAssertTrue(expectedValue == actualValue)
    }
    
    func testCanAppendQueryParameters() {
        guard let url = URL(string: "https://example.com") else {
            XCTFail("could not create URL")
            return
        }
        
        guard let queryParamUrl = url.append(queryParameters: ["param1" : "value1", "param2" : "value2"]) else {
            XCTFail("could not create queryParamUrl")
            return
        }
        
        XCTAssertNotNil(queryParamUrl.value(forParameter: "param1"))
        XCTAssertNotNil(queryParamUrl.value(forParameter: "param2"))

    }
    
}
