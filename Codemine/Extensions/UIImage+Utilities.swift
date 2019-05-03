//
//  UIImage+Utilities.swift
//  Codemine
//
//  Created by Marius Constantinescu on 18/02/16.
//  Copyright © 2016 Nodes. All rights reserved.
//

import Foundation
import UIKit

public extension UIImage {
    /**
     Create an `UIImage` with specified background color, size and corner radius.
     
     Parameter `color` is used for the background color,
     parameter `size` to set the size of the the holder rectangle,
     parameter `cornerRadius` for setting up the rounded corners.
     
     - Parameters:
        - color: The background color.
        - size: The size of the image.
        - cornerRadius: The corner radius.
     
     - Returns: A 'UIImage' with the specified color, size and corner radius.
     */
    
    convenience init(color: UIColor, size: CGSize, cornerRadius: CGFloat) {
        self.init()
        
        /// The base rectangle of the image.
        let rect = CGRect(x: 0, y: 0, width: size.width, height: size.height)
        UIGraphicsBeginImageContext(rect.size)
        
        /// The graphics context of the image.
        let context = UIGraphicsGetCurrentContext()
        context?.setFillColor(color.cgColor)
        context?.fill(rect)
        
        /// Image that will be retured.
        var image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        UIGraphicsBeginImageContext(size)
        
        UIBezierPath(roundedRect: rect, cornerRadius:cornerRadius).addClip()
        image?.draw(in: rect)
        
        image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
    }
    
    
    /**
     Embed an icon/image on top of a background image.
     
     `image` will be the background and `icon` is the image that will be on top of `image`.
     The `UIImage` that is set with the parameter `icon` will be centered on `image`.
     
     - Parameters:
        - icon: The embedded image that will be on top.
        - image: The background image.
     - Returns: The combined image as `UIImage`.
     */
    class func embed(icon: UIImage, inImage image: UIImage ) -> UIImage? {
        let newSize = CGSize(width: image.size.width, height: image.size.height)
        UIGraphicsBeginImageContextWithOptions(newSize, false, 0.0)
        
        image.draw(in: CGRect(x: 0,y: 0,width: newSize.width,height: newSize.height))
        
        // Center icon
        icon.draw(in: CGRect(x: image.size.width/2 - icon.size.width/2, y: image.size.height/2 - icon.size.height/2, width: icon.size.width, height: icon.size.height), blendMode:CGBlendMode.normal, alpha:1.0)
        
        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        return newImage
    }
    
    /**
     Corrects the rotation/orientation of an image.
     When an image inadvertently was taken with the wrong orientation, this function will correct the rotation/orientation again.
     
     - Returns: The orientation corrected image as an `UIImage`.
     */
	var rotationCorrected: UIImage? {
        
        UIGraphicsBeginImageContextWithOptions(self.size, false, self.scale)
        self.draw(in: CGRect(origin: CGPoint.zero, size: self.size))
        let normalizedImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return normalizedImage
    }
}
