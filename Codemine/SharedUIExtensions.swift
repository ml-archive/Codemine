//
//  SharedUIExtensions.swift
//  NOCore
//
//  Created by Kasper Welner on 08/12/15.
//  Copyright © 2015 Nodes. All rights reserved.
//

import Foundation

extension UIColor {
    
    public convenience init(rgb: UInt) {
        self.init(
            red: CGFloat((rgb & 0xFF0000) >> 16) / 255.0,
            green: CGFloat((rgb & 0x00FF00) >> 8) / 255.0,
            blue: CGFloat(rgb & 0x0000FF) / 255.0,
            alpha: CGFloat(1.0)
        )
    }
}

public extension UIImage {
    /**
        Create an `UIImage` with customized background color, size and radius of corners.
     
        Parameter `color` is used for the background color,
        parameter `size` to set the size of the the holder rectangle,
        parameter `cornerRadius` for setting up the rounded corners.
     
        - Parameters:
            - color: Background color as `UIColor`.
            - size: Size of image as `CGSize`.
            - cornerRadius: Radius of corners as `CGFloat`.
     
        - Returns: A customized `UIImage`.
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
            - imageOne: Background image.
            - icon: Embedded image that will be on top.
        - Returns: Combined image as `UIImage`.
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
}

public extension UIView {
    /**
        Assign a `nibName` to a UIView.
        Later on you can call this `UIView` by its `nibName`.
     
        - Parameter nibName: The name that the UIView will get as its `nibName` assigned as a `String`.
        - Returns: `Generics type`.
    */
    public static func viewWithNibNamed<T>(nibName:String) -> T {
        let view = UINib(nibName: nibName, bundle: nil).instantiateWithOwner(nil, options: nil).first! as! T
        return view
    }
    
    /**
        Rounded corners for a `UIView`.
     
        - Parameters:
            - corners: Defines which corners should be rounded.
            - radius: Defines the radius of the round corners as a `CGFloat`.
    */
    public func roundViewCorners(corners:UIRectCorner, radius: CGFloat) {
        let path = UIBezierPath(roundedRect: self.bounds, byRoundingCorners: corners, cornerRadii: CGSize(width: radius, height: radius))
        let mask = CAShapeLayer()
        mask.path = path.CGPath
        self.layer.mask = mask
    }
}

public extension CGRect {
    /// Getter & Setter for a `CGRect`'s  `origin.y`
    public var y: CGFloat {
        set {
            self = CGRect(origin: CGPointMake(origin.x, newValue), size: size)
        }
        get {
            return self.origin.y
        }
    }
    
    /// Getter & Setter for a `CGRect`s `origin.x`
    public var x: CGFloat {
        set {
            self = CGRect(origin: CGPointMake(newValue, origin.y), size: size)
        }
        get {
            return self.origin.x
        }
    }
    
    /// Reversing width and height of a CGRect
    public func rectByReversingSize() -> CGRect {
        return CGRect(origin: self.origin, size: CGSizeMake(self.height, self.width))
    }
}

/// Add Operator `+` for two `CGSizes` to summerise both to one `CGSize`.
public func + (left: CGSize, right: CGSize) -> CGSize {
    return CGSize(width: left.width + right.width, height: left.height + right.height)
}

public extension CGPoint {
    /**
        Check if a `CGPoint` is close to another `CGPoint`.
        There is a tolerance that defines the range that is tolerated to call it close to another `CGPoint`.
        If the actual point is close to the `point` from the parameter it will return true.
     
        - Parameters:
            - point: The `CGPoint` that will be checked if it is close to the actual `CGPoint`.
            - tolerance: Defines what range is tolerated to be close to the other `point`.
     
        - Returns: `Boolean` - if close to return true, else false.
    */
    func isCloseTo(point: CGPoint, tolerance: CGFloat) -> Bool {
        let xIsClose = self.x <= point.x + tolerance && self.x >= point.x - tolerance
        let yIsClose = self.y <= point.y + tolerance && self.y >= point.y - tolerance
        return xIsClose && yIsClose
    }
}

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

public extension NSURL {
    /**
        Mode for image urls.
        It defines in which mode an image will be provided.
     
        - Resize: Resize image mode. The image can be streched or compressed.
        - Crop: Cropped image mode. It will crop into an image so only a part of the image will be provided.
                 If no value is explicitly set, the default behavior is to center the image.
        - Fit: Resizes the image to fit within the width and height boundaries without cropping or distorting the image. 
                The resulting image is assured to match one of the constraining dimensions, 
                while the other dimension is altered to maintain the same aspect ratio of the input image.
        - Default: Default/normal image mode. No changes to the ratio.
    */
    public enum ImageUrlMode : String {
        case Resize = "resize"
        case Crop   = "crop"
        case Fit    = "fit"
        case Default = "default"
    }
    
    /**
        Choose the `size` and the `mode` for the image url to define how an image will be provided from the backend.
     
        - Parameters: 
            - size: Set `size` as `CGSize` to define the size of the image that will be provided.
            - mode: Select a mode from predefined `ImageUrlMode` to set up a mode and define how an image will be provided.
        - Returns: `URL` as a `NSURL`.
    */
    public func urlByAppendingSize(size: CGSize, mode:ImageUrlMode = .Default) -> NSURL {
        let urlComponents = NSURLComponents(URL: self, resolvingAgainstBaseURL: false)
        if let urlComponents = urlComponents {
            if NSFoundationVersionNumber > NSFoundationVersionNumber_iOS_7_1 {
                var queryItems:[NSURLQueryItem] = urlComponents.queryItems ?? []
                queryItems.append(NSURLQueryItem(name: "w", value: "\(size.width * UIScreen.mainScreen().scale )"))
                queryItems.append(NSURLQueryItem(name: "h", value: "\(size.height * UIScreen.mainScreen().scale)"))
                if mode != .Default {
                    queryItems.append(NSURLQueryItem(name: "mode", value: mode.rawValue))
                }
                urlComponents.queryItems = queryItems
            } else {
                var query = urlComponents.query ?? ""
                if query.characters.count > 0 {
                    query += "?"
                } else {
                    query += "&"
                }
                
                query += "width=\(size.width)&height=\(size.height)"
                urlComponents.query = query
            }
            return urlComponents.URL ?? self
        }
        
        print("Could not parse components for url: \(self)")
        return self
    }
}

public extension UIImage {
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
