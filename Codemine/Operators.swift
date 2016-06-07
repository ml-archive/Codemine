//
//  Operators.swift
//  Codemine
//
//  Created by Marius Constantinescu on 18/02/16.
//  Copyright © 2016 Nodes. All rights reserved.
//

import Foundation
import CoreGraphics

/// Add Operator `+` for two `CGPoints` to summerise them to one `CGPoint`.
public func + (left: CGPoint, right: CGPoint) -> CGPoint {
    return CGPoint(x: left.x + right.x, y: left.y + right.y)
}

/// Add Operator `*` for two `CGPoints` to multiply both with each other to one `CGPoint`.
public func * (left: CGPoint, right: CGPoint) -> CGPoint {
    return CGPoint(x: left.x * right.x, y: left.y * right.y)
}

/// Add Operator `*` to multiply a CGPoint to a CGFloat to get a CGPoint.
public func * (left: CGPoint, right: CGFloat) -> CGPoint {
    return CGPoint(x: left.x * right, y: left.y * right)
}

/// Add Operator `-` for two `CGPoints` subtract the `right` from the `left` `CGPoint`.
public func - (left: CGPoint, right: CGPoint) -> CGPoint {
    return CGPoint(x: left.x - right.x, y: left.y - right.y)
}

/// Add Operator `/` to devide a `CGPoints` by the value of a `CGFloat`.
public func / (left: CGPoint, right: CGFloat) -> CGPoint {
    return CGPoint(x: left.x / right, y: left.y / right)
}

/// Add Operator `/` for two `CGPoints`. The left will be devided by the right one.
public func / (left: CGPoint, right: CGPoint) -> CGPoint {
    return CGPoint(x: left.x / right.x, y: left.y / right.y)
}

/// Add Operator `+` for two `CGSizes` to summerise both to one `CGSize`.
public func + (left: CGSize, right: CGSize) -> CGSize {
    return CGSize(width: left.width + right.width, height: left.height + right.height)
}