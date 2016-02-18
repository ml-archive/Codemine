//
//  Protocols.swift
//  Codemine
//
//  Created by Dominik Hádl on 14/02/16.
//  Copyright © 2016 Nodes. All rights reserved.
//

import Foundation

public protocol NibInstantiable: class {
    static func newFromNib<T>() -> T
}