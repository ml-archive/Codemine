//
//  CodemineTests.swift
//  CodemineTests
//
//  Created by Chris Combs on 26/01/16.
//  Copyright © 2016 Nodes. All rights reserved.
//

import XCTest
@testable import Codemine

class CodemineTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testExample() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }
    
    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }
    
    // MARK: - String Extensions tests
    
    func testTrueEmailAddress() {
        let validEmails = ["TeSt@TesT.COM", "Test@test.com", "email@example.com", "firstname.lastname@example.com", "email@subdomain.example.com", "firstname+lastname@example.com", "1234567890@example.com", "email@example-one.com", "_______@example.com", "email@example.name", "email@example.museum", "email@example.co.jp", "firstname-lastname@example.com"]
        for emailAddress in validEmails {
            XCTAssertTrue(emailAddress.isValidEmailAddress, "the email address: \(emailAddress) was considered invalid, but it is not")
        }
    }
    
    func testFalseEmailAddress() {
        let invalidEmails = ["plainaddress", "#@%^%#$@#$@#.com", "@example.com", "Joe Smith <email@example.com>", "email.example.com", "email@example@example.com", ".email@example.com", "email.@example.com", "email..email@example.com", "あいうえお@example.com", "email@example.com (Joe Smith)", "email@example", "email@-example.com", "email@example..com", "Abc..123@example.com"]
        for emailAddress in invalidEmails {
            XCTAssertFalse(emailAddress.isValidEmailAddress, "the email address: \(emailAddress) was considered valid, but it is not")
        }
    }
    
    func testRange() {
        let str = "Hello world!"
		let range = str.range(from: "e", toString: " w")
        XCTAssertTrue(range?.lowerBound == str.index(str.startIndex, offsetBy: 1) && range?.upperBound == str.index(str.startIndex, offsetBy: 7), "range = \(String(describing: range))")
        XCTAssertNil(str.range(from: "a", toString: "e"))
        XCTAssertNil(str.range(from: "e", toString: "b"))
		
        XCTAssertNil(str.range(from: "l", toString: "o", searchType: .rightToLeft, inRange: range))
        
        let str2 = "abcdefghijklmnopqrstuvwxyz"
        let range2 = str2.range(from: "x", toString: "z")
        XCTAssertNil(str.range(from: "h", toString: "e", searchType: .leftToRight, inRange: range2))
        
        
    }
    
    func testCamerlCaseToUnderscore() {
        let snakeCaseStr1 = "user_id"
        let camelCaseStr1 = "userId"
        let snakeCaseStr2 = "is_user_active_member_of_current_group"
        let camelCaseStr2 = "isUserActiveMemberOfCurrentGroup"
        
        XCTAssertEqual(snakeCaseStr1, camelCaseStr1.camelCaseToUnderscore())
        XCTAssertEqual(snakeCaseStr2, camelCaseStr2.camelCaseToUnderscore())
    }
    
    
    // MARK: - CGRect Extensions tests
    
    func testX() {
        var rect = CGRect(x: 10, y: 10, width: 100, height: 100)
        XCTAssertEqual(rect.x, rect.origin.x)
        
        rect.x = 20
        XCTAssertEqual(rect.origin.x, 20)
    }
    
    func testY() {
        var rect = CGRect(x: 10, y: 10, width: 100, height: 100)
        XCTAssertEqual(rect.y, rect.origin.y)
        
        rect.y = 20
        XCTAssertEqual(rect.origin.y, 20)
    }
    
    func testReversingSize() {
        let rect = CGRect(x: 10, y: 10, width: 100, height: 200)
        let reversedRect = rect.reversingSize
        XCTAssertTrue(rect.size.height == reversedRect.size.width && rect.size.width == reversedRect.size.height)
    }
    
    func testSizeAddition() {
        let size1 = CGSize(width: 20, height: 40)
        let size2 = CGSize(width: 121, height: 576)
        XCTAssertEqual(size1+size2, CGSize(width: size1.width + size2.width, height: size1.height+size2.height))
    }
    
    // MARK: - CGPoint extension tests
    
    func testIsClosePoint() {
        let point1 = CGPoint(x: 0, y: 0)
        let point2 = CGPoint(x: 0, y: 1)
        let point3 = CGPoint(x: 1, y: 1)
        let point4 = CGPoint(x: 10, y: 10)
        XCTAssertTrue(point1.isCloseTo(point2, tolerance: 1))
        XCTAssertFalse(point1.isCloseTo(point2, tolerance: 0.5))
        XCTAssertTrue(point1.isCloseTo(point3, tolerance: 2))
        XCTAssertFalse(point2.isCloseTo(point4, tolerance: 3))
    }
    
    func testPointAddition() {
        let point1 = CGPoint(x: 10, y: 11)
        let point2 = CGPoint(x: 2, y: 13)
        XCTAssertTrue((point1+point2).x == point1.x + point2.x && (point1+point2).y == point1.y + point2.y)
        
    }
    
    func testPointMultiplication() {
        let point1 = CGPoint(x: 10, y: 11)
        let point2 = CGPoint(x: 2, y: 13)
        XCTAssertTrue((point1*point2).x == point1.x * point2.x && (point1*point2).y == point1.y * point2.y)
        
    }
    
    func testPointWithScalarMultiplication() {
        let point1 = CGPoint(x: 10, y: 11)
        let scalar : CGFloat = 4
        XCTAssertTrue((point1*scalar).x == point1.x * scalar && (point1*scalar).y == point1.y * scalar)
        
    }
    
    func testPointSubtraction() {
        let point1 = CGPoint(x: 10, y: 11)
        let point2 = CGPoint(x: 2, y: 13)
        XCTAssertTrue((point1-point2).x == point1.x - point2.x && (point1-point2).y == point1.y - point2.y)
        
    }
    
    func testPointDivision() {
        let point1 = CGPoint(x: 10, y: 11)
        let point2 = CGPoint(x: 2, y: 13)
        XCTAssertTrue((point1/point2).x == point1.x / point2.x && (point1/point2).y == point1.y / point2.y)
        
        let point3 = CGPoint(x: 0, y: 0)
        XCTAssertTrue((point1/point3).x == point1.x / point3.x && (point1/point3).y == point1.y / point3.y)
        
    }
    
    func testPointByScalarDivision() {
        let point1 = CGPoint(x: 10, y: 11)
        let scalar : CGFloat = 4
        XCTAssertTrue((point1/scalar).x == point1.x / scalar && (point1/scalar).y == point1.y / scalar)
        
        let scalar2 : CGFloat = 0
        XCTAssertTrue((point1/scalar2).x == point1.x / scalar2 && (point1/scalar2).y == point1.y / scalar2)
        
    }
    
    // MARK: - Then test
    func testThen() {
        let view = UIView().then {
            $0.backgroundColor = UIColor.black
            $0.alpha = 0.5
        }
        
        XCTAssertEqual(view.alpha, 0.5)
        XCTAssertEqual(view.backgroundColor, UIColor.black)
    }
    
    // MARK: - UIColor extension test
    func testColor() {
        let red = UIColor(rgb: 0xFF0000)
        let blue = UIColor(rgb: 0x0000FF)
        let magenta = UIColor(rgb: 0xFF00FF)
        
        XCTAssertEqual(red, UIColor.red)
        XCTAssertEqual(blue, UIColor.blue)
        XCTAssertEqual(magenta, UIColor.magenta)
        XCTAssertNotEqual(red, UIColor.yellow)
    }
        
    func testError() {
        let domain = "Domain"
        let code = 123
        let description = "error description"
        let error = NSError(domain: domain, code: code, description: description)
        let error2 = NSError(domain: domain, code: code, userInfo: [NSLocalizedDescriptionKey : description])
        XCTAssertEqual(error, error2)
    }

    // MARK: - XCTestCase extension test
    func testThrowsSpecificError() {
        //Sample types
        enum MyError: Error {
            case specificError
        }

        func throwIt() throws {
            throw MyError.specificError
        }

        //Actually test
        XCTAssertThrows(try throwIt(), specificError: MyError.specificError)
    }
}
