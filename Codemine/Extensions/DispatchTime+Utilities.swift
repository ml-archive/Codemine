//
//  DispatchTime+Utilities.swift
//  Codemine
//
//  Created by Marius Constantinescu on 11/11/2016.
//  Copyright © 2016 Nodes. All rights reserved.
//

import Foundation

// Credits for this go to Russ Bishop http://www.russbishop.net/quick-easy-dispatchtime

extension DispatchTime: ExpressibleByIntegerLiteral {
    public init(integerLiteral value: Int) {
        self = DispatchTime.now() + .seconds(value)
    }
}

extension DispatchTime: ExpressibleByFloatLiteral {
    public init(floatLiteral value: Double) {
        self = DispatchTime.now() + .milliseconds(Int(value * 1000))
    }
}
