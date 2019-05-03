//
//  CGRect+Utilities.swift
//  Codemine
//
//  Created by Marius Constantinescu on 18/02/16.
//  Copyright © 2016 Nodes. All rights reserved.
//

import Foundation
import CoreGraphics

public extension CGRect {
    /// Getter & Setter for a `CGRect`'s  `origin.y`
    var y: CGFloat {
        set {
            self = CGRect(origin: CGPoint(x: origin.x, y: newValue), size: size)
        }
        get {
            return self.origin.y
        }
    }
    
    /// Getter & Setter for a `CGRect`s `origin.x`
    var x: CGFloat {
        set {
            self = CGRect(origin: CGPoint(x: newValue, y: origin.y), size: size)
        }
        get {
            return self.origin.x
        }
    }
    
    /**
     Reverses the width and height of a 'CGRect'
     
     - returns: a new CGRect with the width and height reversed to those of the current one
     */
	var reversingSize: CGRect {
        return CGRect(origin: origin, size: CGSize(width: height, height: width))
    }
}
