//
//  UIImageTests.swift
//  Codemine
//
//  Created by Chris on 25/09/2016.
//  Copyright © 2016 Nodes. All rights reserved.
//

import XCTest
@testable import Codemine

class UIImageTests: XCTestCase {
	
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
	
	func testImageNamed(name: String) -> UIImage {
		let bundle = Bundle(for: type(of: self))
		let path = bundle.path(forResource: name, ofType: "png")!
		return UIImage(contentsOfFile: path)!
	}
	
	func testUIImageFromColor() {
		XCTAssertNotNil(UIImage(color: .red, size: CGSize(width: 20, height: 20), cornerRadius: 1.0), "Failed to convert color to image")
	}
	
	func testImageEmbed() {
		XCTAssertNotNil(UIImage.embed(icon: testImageNamed(name: "alert"), inImage: testImageNamed(name: "add")), "Failed to embed image")
	}
	
	func testImageRotation() {
		XCTAssertNotNil(testImageNamed(name: "add").rotationCorrected, "Failed to rotate image")
	}
	
}
