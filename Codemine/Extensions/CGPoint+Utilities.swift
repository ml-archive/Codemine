//
//  CGPoint+Utilities.swift
//  Codemine
//
//  Created by Marius Constantinescu on 18/02/16.
//  Copyright © 2016 Nodes. All rights reserved.
//

import Foundation
import CoreGraphics

public extension CGPoint {
    /**
     Check if a `CGPoint` is close to another `CGPoint`.
     There is a tolerance that defines the range that is tolerated to call it close to another `CGPoint`.
     If the actual point is close to the `point` from the parameter it will return true.
     
     - Parameters:
        - point: The `CGPoint` that will be checked if it is close to the actual `CGPoint`.
        - tolerance: Defines what range is tolerated to be close to the other `point`.
     
     - Returns: `Boolean` - if close to return true, else false.
     */
    func isCloseTo(_ point: CGPoint, tolerance: CGFloat) -> Bool {
        let xIsClose = self.x <= point.x + tolerance && self.x >= point.x - tolerance
        let yIsClose = self.y <= point.y + tolerance && self.y >= point.y - tolerance
        return xIsClose && yIsClose
    }
}

