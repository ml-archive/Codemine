//
//  UIView+Animations.swift
//  Codemine
//
//  Created by Quinton Pryce on 2019-10-26.
//  Copyright © 2019 Nodes. All rights reserved.
//

import UIKit

extension UIView {
    
    /// Animates the `alpha` of your `UIView`.
    ///
    /// - Parameter alpha: The desired alpha for your view.
    /// - Parameter duration: The duration of the animation.
    /// - Parameter completion: The completion to be executed once the animation completes.
    func animate(alpha: CGFloat, duration: Double = 0.2, completion: ((Bool) -> Void)? = nil) {
        UIView.animate(withDuration: duration, delay: 0, options: AnimationOptions.curveEaseInOut, animations: {
            self.alpha = alpha
        }, completion: completion)
    }
}
