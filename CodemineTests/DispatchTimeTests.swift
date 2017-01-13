//
//  DispatchTimeTests.swift
//  Codemine
//
//  Created by Marius Constantinescu on 16/12/2016.
//  Copyright © 2016 Nodes. All rights reserved.
//

import XCTest

class DispatchTimeTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
    }
    
    func testAfterDispatchTime() {
        let expectation = self.expectation(description: "The duration should be 3.2 seconds")
        
        DispatchQueue.main.asyncAfter(deadline: 3.2) {
            expectation.fulfill()
        }
        
        waitForExpectations(timeout: 3.2 + 0.005, handler: nil)
        
    }
    
    func testAfterIntegerDispatchTime() {
        let expectation = self.expectation(description: "The duration should be 3 seconds")
        
        DispatchQueue.main.asyncAfter(deadline: 3) {
            expectation.fulfill()
        }
        
        waitForExpectations(timeout: 3 + 0.005, handler: nil)
        
    }
    
}
