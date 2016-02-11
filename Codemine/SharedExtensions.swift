//
//  Extensions.swift
//  NOCore
//
//  Created by Chris Combs on 24/03/15.
//  Copyright (c) 2015 Nodes. All rights reserved.
//

import Foundation

/**
Create a delay for some functions or some code.

- Parameters:
    - delay: Delaytime in seconds as `Double`
    - closure: Function that should be called after the delay.
*/
public func delay(delay:Double, closure:()->()) {
    dispatch_after(
        dispatch_time(
            DISPATCH_TIME_NOW,
            Int64(delay * Double(NSEC_PER_SEC))
        ),
        dispatch_get_main_queue(), closure)
}

public protocol NibInstantiable: class {
    static func newFromNib<T>() -> T
}


