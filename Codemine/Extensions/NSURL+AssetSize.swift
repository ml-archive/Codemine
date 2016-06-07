//
//  NSURL+AssetSize.swift
//  Codemine
//
//  Created by Marius Constantinescu on 18/02/16.
//  Copyright © 2016 Nodes. All rights reserved.
//

import Foundation
import CoreGraphics
import UIKit

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
     Adds height, width and mode paramters to an url. To be used when fetching an image from a CDN, for example.
     Choose the `size` and the `mode` for the image url to define how an image will be provided from the backend.
     
     - Parameters:
     - size: Set `size` as `CGSize` to define the size of the image that will be provided.
     - mode: Select a mode from predefined `ImageUrlMode` to set up a mode and define how an image will be provided.
     - heightParameterName: the name of the height paramter. Default is 'h'
     - widthParameterName: the name of the width paramter. Default is 'h'
     - Returns: `URL` as a `NSURL`.
     */
    public func urlByAppendingAssetSize(size: CGSize, mode: ImageUrlMode = .Default, heightParameterName : String = "h", widthParameterName : String = "w") -> NSURL {
        guard let urlComponents = NSURLComponents(URL: self, resolvingAgainstBaseURL: false) else { return self }
        
        var queryItems:[NSURLQueryItem] = urlComponents.queryItems ?? []
        queryItems.append(NSURLQueryItem(name: widthParameterName, value: "\(Int(size.width * UIScreen.mainScreen().scale ))"))
        queryItems.append(NSURLQueryItem(name: heightParameterName, value: "\(Int(size.height * UIScreen.mainScreen().scale ))"))
        if mode != .Default {
            queryItems.append(NSURLQueryItem(name: "mode", value: mode.rawValue))
        }
        urlComponents.queryItems = queryItems
        return urlComponents.URL ?? self
    }
}
