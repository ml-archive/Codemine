//
//  UIViewController+Utilities.swift
//  Codemine
//
//  Created by Chris on 30/08/2017.
//  Copyright © 2017 Nodes. All rights reserved.
//

import Foundation
import UIKit

/**
 Create a UIViewController from a nib with a matching name

 - Returns: a viewcontroller of type Self.
 */

extension NibInitializable where Self: UIViewController {
    public static func fromNib() -> Self {
        return Self(nibName:"\(self)", bundle: nil)
    }
}
