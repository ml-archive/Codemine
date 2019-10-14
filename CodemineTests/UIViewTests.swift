//
//  UIViewTests.swift
//  CodemineTests
//
//  Created by Style Theory on 14/10/19.
//  Copyright © 2019 Nodes. All rights reserved.
//

import XCTest

class UIViewTests: XCTestCase {

    override func setUp() {
        super.setUp()
    }

    override func tearDown() {
        super.tearDown()
    }
    
    func testHideThenReveal() {
        let view = UIView(frame: CGRect(x: 0, y: 0, width: 100, height: 100))
        view.hide()
        XCTAssertEqual(view.isHidden, true)
        view.reveal()
        XCTAssertEqual(view.isHidden, false)
    }

}
