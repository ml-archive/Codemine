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
        
        let expectedValue1 = "value1"
        let expectedValue2 = "value2"
        
        guard let queryParamUrl = url.append(queryParameters: ["param1" : expectedValue1, "param2" : expectedValue2]) else {
            XCTFail("could not create queryParamUrl")
            return
        }
        
        //Are they even there?
        XCTAssertNotNil(queryParamUrl.value(forParameter: "param1"))
        XCTAssertNotNil(queryParamUrl.value(forParameter: "param2"))
        
        //They were, but do they match then?
        XCTAssertTrue(queryParamUrl.value(forParameter: "param1")! == expectedValue1)
        XCTAssertTrue(queryParamUrl.value(forParameter: "param2")! == expectedValue2)

    }
    
    func testCanChangeQueryParameters() {
        guard let url = URL(string: "http://example.com?token=addtokenhere") else {
            XCTFail("could not create URL")
            return
        }

        let expectedValue = "http://example.com?token=usertoken"

        guard let queryParamUrl = url.changeQueryParamValue(withName: "token", to: "usertoken") else {
            XCTFail("could not change queryParamUrl")
            return
        }

        //Is the param even there?
        XCTAssertNotNil(queryParamUrl.value(forParameter: "token"))

        //It is, but does it match?
        XCTAssertTrue(queryParamUrl.absoluteString == expectedValue)
    }
    
    func testChangeQueryParametersWithWrongInput() {
        guard let url = URL(string: "http://example.com?token=addtokenhere") else {
            XCTFail("could not create URL")
            return
        }

        //Trying with a queryparam that's not in the url - expecting nil
        XCTAssertNil(url.changeQueryParamValue(withName: "username", to: "usertoken"))

    }
    
}
