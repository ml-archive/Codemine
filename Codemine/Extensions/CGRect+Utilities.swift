//
//  CGRect+Utilities.swift
//  Codemine
//
//  Created by Marius Constantinescu on 18/02/16.
//  Copyright © 2016 Nodes. All rights reserved.
//

import Foundation


public extension CGRect {
    /// Getter & Setter for a `CGRect`'s  `origin.y`
    public var y: CGFloat {
        set {
            self = CGRect(origin: CGPointMake(origin.x, newValue), size: size)
        }
        get {
            return self.origin.y
        }
    }
    
    /// Getter & Setter for a `CGRect`s `origin.x`
    public var x: CGFloat {
        set {
            self = CGRect(origin: CGPointMake(newValue, origin.y), size: size)
        }
        get {
            return self.origin.x
        }
    }
    
    /**
     Reverses the width and height of a 'CGRect'
     
     - returns: a new CGRect with the width and height reversed to those of the current one
     */
    public func rectByReversingSize() -> CGRect {
        return CGRect(origin: self.origin, size: CGSizeMake(self.height, self.width))
    }
}