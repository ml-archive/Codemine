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
    func roundCorners(_ corners: CACornerMask, radius: CGFloat) {
        if #available(iOS 11, *) {
            clipsToBounds = true
            layer.cornerRadius = radius
            layer.maskedCorners = corners
        } else {
            let cornerRadii = CGSize(width: radius, height: radius)
            let path = UIBezierPath(
                roundedRect: bounds,
                byRoundingCorners: corners.uiRectCorner,
                cornerRadii: cornerRadii
            )
            
            let mask = CAShapeLayer()
            mask.path = path.cgPath
            layer.mask = mask
        }
    }
}

private extension CACornerMask {
    
    var uiRectCorner: UIRectCorner {
        var cornerMask = UIRectCorner()
        
        if(contains(.layerMinXMinYCorner)){ cornerMask.insert(.topLeft) }
        
        if(contains(.layerMaxXMinYCorner)){ cornerMask.insert(.topRight) }
        
        if(contains(.layerMinXMaxYCorner)){ cornerMask.insert(.bottomLeft) }
        
        if(contains(.layerMaxXMaxYCorner)){ cornerMask.insert(.bottomRight) }
        
        return cornerMask
    }
}
