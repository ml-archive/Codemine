//
//  UIColor+Hex.swift
//  Codemine
//
//  Created by Marius Constantinescu on 18/02/16.
//  Copyright © 2016 Nodes. All rights reserved.
//

import Foundation
import UIKit

public extension UIColor {
    
    /**
     Convenience initializer for
     
     - parameter rgb: UInt value in hex of the color. For example, 0xFF0000 or 0x00FFFF
     
     - returns: a UIColor with the specified hex value
     */
    convenience init(rgb: UInt) {
        self.init(
            red: CGFloat((rgb & 0xFF0000) >> 16) / 255.0,
            green: CGFloat((rgb & 0x00FF00) >> 8) / 255.0,
            blue: CGFloat(rgb & 0x0000FF) / 255.0,
            alpha: CGFloat(1.0)
        )
    }
}
