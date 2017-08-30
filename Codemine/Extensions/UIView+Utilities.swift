//
//  UIView+Utilities.swift
//  Codemine
//
//  Created by Marius Constantinescu on 18/02/16.
//  Copyright © 2016 Nodes. All rights reserved.
//

import Foundation
import UIKit

public extension UIView {
    /**
     Assign a `nibName` to a UIView.
     Later on you can call this `UIView` by its `nibName`.
     
     - Parameter name: The name that the UIView will get as its `name` assigned as a `String`.
     - Returns: `Generics type`.
     */
    public static func from<T>(nibWithName:String) -> T? {
        return UINib(nibName: nibWithName, bundle: nil).instantiate(withOwner: nil, options: nil).first as? T
    }


    /**
     Rounded corners for a `UIView`.
     
     - Parameters:
     - corners: Defines which corners should be rounded.
     - radius: Defines the radius of the round corners as a `CGFloat`.
     */
    public func roundViewCorners(_ corners:UIRectCorner, radius: CGFloat) {
        let path = UIBezierPath(roundedRect: self.bounds, byRoundingCorners: corners, cornerRadii: CGSize(width: radius, height: radius))
        let mask = CAShapeLayer()
        mask.path = path.cgPath
        self.layer.mask = mask
    }
}

/**
 Create a UIView from a nib with a matching name

 - Returns: a view of type Self.
 */
extension NibInitializable where Self: UIView {
    public static func fromNib() -> Self {
        return UINib(nibName:nibName, bundle: nil).instantiate(withOwner: nil, options: nil).first as! Self
    }
}

extension UIView: NibInitializable {
    public static var nibName: String { return "\(self)" }
}

