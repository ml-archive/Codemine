//
//  XCTestCase+Utilities.swift
//  Codemine
//
//  Created by HE:labs on 18/10/17.
//  Copyright © 2017 Nodes. All rights reserved.
//

import XCTest

extension XCTestCase {
    func XCTAssertThrows<T, E>(_ expression: @autoclosure () throws -> T, specificError: E) where E: Error, E: Equatable  {

        XCTAssertThrowsError(try expression()) { error in
            XCTAssertEqual(error as? E, specificError)
        }

    }
}
