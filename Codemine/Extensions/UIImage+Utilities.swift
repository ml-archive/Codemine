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
    public class func imageFromColor(color: UIColor, size: CGSize, cornerRadius: CGFloat) -> UIImage {
        
        /// The base rectangle of the image.
        let rect = CGRectMake(0, 0, size.width, size.height)
        UIGraphicsBeginImageContext(rect.size)
        
        /// The graphics context of the image.
        let context = UIGraphicsGetCurrentContext()
        CGContextSetFillColorWithColor(context, color.CGColor)
        CGContextFillRect(context, rect)
        
        /// Image that will be retured.
        var image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        UIGraphicsBeginImageContext(size)
        
        UIBezierPath(roundedRect: rect, cornerRadius:cornerRadius).addClip()
        image .drawInRect(rect)
        
        image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        return image
    }
    
    /**
     Embed an icon/image on top of a background image.
     
     `imageOne` will be the background and `icon` is the image that will be on top of `imageOne`.
     The `UIImage` that is set with the parameter `icon` will be centered on `imageOne`.
     
     - Parameters:
     - imageOne: The background image.
     - icon: The embedded image that will be on top.
     - Returns: The combined image as `UIImage`.
     */
    public class func imageByEmbeddingIconIn(imageOne: UIImage, icon: UIImage) -> UIImage {
        let newSize = CGSizeMake(imageOne.size.width, imageOne.size.height)
        UIGraphicsBeginImageContextWithOptions(newSize, false, 0.0)
        
        imageOne.drawInRect(CGRectMake(0,0,newSize.width,newSize.height))
        
        // Center icon
        icon.drawInRect(CGRectMake(imageOne.size.width/2 - icon.size.width/2, imageOne.size.height/2 - icon.size.height/2, icon.size.width, icon.size.height), blendMode:CGBlendMode.Normal, alpha:1.0)
        
        let newImage:UIImage = UIGraphicsGetImageFromCurrentImageContext()
        return newImage
    }
    
    /**
     Corrects the rotation/orientation of an image.
     When an image inadvertently was taken with the wrong orientation, this function will correct the rotation/orientation again.
     
     - Returns: The orientation corrected image as an `UIImage`.
     */
    public func rotationCorrectedImage() -> UIImage {
        //        if (self.imageOrientation == UIImageOrientation.Up) { return self }
        
        UIGraphicsBeginImageContextWithOptions(self.size, false, self.scale);
        self.drawInRect(CGRect(origin: CGPointZero, size: self.size))
        let normalizedImage = UIGraphicsGetImageFromCurrentImageContext();
        UIGraphicsEndImageContext();
        return normalizedImage;
    }
}
