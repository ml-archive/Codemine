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
    static func from<T>(nibWithName:String) -> T? {
        let view = UINib(nibName: nibWithName, bundle: nil).instantiate(withOwner: nil, options: nil).first as? T
        return view
    }
    
    /**
     Rounded corners for a `UIView`.
     
     - Parameters:
        - corners: Defines which corners should be rounded.
        - radius: Defines the radius of the round corners as a `CGFloat`.
     */
    func roundViewCorners(_ corners:UIRectCorner, radius: CGFloat) {
        let path = UIBezierPath(roundedRect: self.bounds, byRoundingCorners: corners, cornerRadii: CGSize(width: radius, height: radius))
        let mask = CAShapeLayer()
        mask.path = path.cgPath
        self.layer.mask = mask
    }
}


