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

///
public extension UIImage {
    /**
    Create an image with customized background color, size and radius of edges.
     
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
    The `UIImage` that is set with the parameter `icon` will always be centered on `imageOne`.
     
    - Parameters:
        - imageOne: Background image.
        - icon: Inner image that will be embedded.
    - Returns: Combined image as `UIImage`.
    */
    public class func imageByEmbeddingIconIn(imageOne: UIImage, icon: UIImage) -> UIImage {
        let newSize = CGSizeMake(imageOne.size.width, imageOne.size.height)
        UIGraphicsBeginImageContextWithOptions(newSize, false, 0.0)
        
        imageOne.drawInRect(CGRectMake(0,0,newSize.width,newSize.height))
        
        // Center icon in holder rectangle
        icon.drawInRect(CGRectMake(imageOne.size.width/2 - icon.size.width/2, imageOne.size.height/2 - icon.size.height/2, icon.size.width, icon.size.height), blendMode:CGBlendMode.Normal, alpha:1.0)
        
        let newImage:UIImage = UIGraphicsGetImageFromCurrentImageContext()
        return newImage
    }
}

public extension UIView {
    
    public static func viewWithNibNamed<T>(nibName:String) -> T {
        let view = UINib(nibName: nibName, bundle: nil).instantiateWithOwner(nil, options: nil).first! as! T
        return view
    }
    
    public func roundViewCorners(corners:UIRectCorner, radius: CGFloat) {
        let path = UIBezierPath(roundedRect: self.bounds, byRoundingCorners: corners, cornerRadii: CGSize(width: radius, height: radius))
        let mask = CAShapeLayer()
        mask.path = path.CGPath
        self.layer.mask = mask
    }
}

public extension CGRect {
    public var y: CGFloat {
        set {
            self = CGRect(origin: CGPointMake(origin.x, newValue), size: size)
        }
        get {
            return self.origin.y
        }
    }
    
    public var x: CGFloat {
        set {
            self = CGRect(origin: CGPointMake(newValue, origin.y), size: size)
        }
        get {
            return self.origin.x
        }
    }
    
    private var height: CGFloat {
        set {
            self = CGRect(origin: origin, size: CGSize(width: size.width, height: newValue))
        }
        get {
            return self.size.height
        }
    }
    
    private var width: CGFloat {
        set {
            self = CGRect(origin: origin, size: CGSize(width: newValue, height: self.height))
        }
        get {
            return self.size.width
        }
    }
    
    public func rectByReversingSize() -> CGRect {
        return CGRect(origin: self.origin, size: CGSizeMake(self.height, self.width))
    }
}

public func + (left: CGSize, right: CGSize) -> CGSize {
    return CGSize(width: left.width + right.width, height: left.height + right.height)
}

public extension CGPoint {
    func isCloseTo(point: CGPoint, tolerance: CGFloat) -> Bool {
        let xIsClose = self.x < point.x + tolerance && self.x > point.x - tolerance
        let yIsClose = self.y < point.y + tolerance && self.y > point.y - tolerance
        return xIsClose && yIsClose
    }
}

public func + (left: CGPoint, right: CGPoint) -> CGPoint {
    return CGPoint(x: left.x + right.x, y: left.y + right.y)
}

public func * (left: CGPoint, right: CGPoint) -> CGPoint {
    return CGPoint(x: left.x * right.x, y: left.y * right.y)
}

public func * (left: CGPoint, right: CGFloat) -> CGPoint {
    return CGPoint(x: left.x * right, y: left.y * right)
}

public func - (left: CGPoint, right: CGPoint) -> CGPoint {
    return CGPoint(x: left.x - right.x, y: left.y - right.y)
}

public func / (left: CGPoint, right: CGFloat) -> CGPoint {
    return CGPoint(x: left.x / right, y: left.y / right)
}

public func / (left: CGPoint, right: CGPoint) -> CGPoint {
    return CGPoint(x: left.x / right.x, y: left.y / right.y)
}

public extension NSURL {
    public enum ImageUrlMode : String {
        case Resize = "resize"
        case Crop   = "crop"
        case Fit    = "fit"
        case Default = "default"
    }
    
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
    public func rotationCorrectedImage() -> UIImage {
        //        if (self.imageOrientation == UIImageOrientation.Up) { return self }
        
        UIGraphicsBeginImageContextWithOptions(self.size, false, self.scale);
        self.drawInRect(CGRect(origin: CGPointZero, size: self.size))
        let normalizedImage = UIGraphicsGetImageFromCurrentImageContext();
        UIGraphicsEndImageContext();
        return normalizedImage;
    }
}
