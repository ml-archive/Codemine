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

public extension URL {
    /**
     Mode for image urls.
     It defines in which mode an image will be provided.
     
     - Resize: Resize image mode. The image can be streched or compressed.
     - Crop: Cropped image mode. It will crop into an image so only a part of the image will be provided.
     If no value is explicitly set, the default behavior is to center the image.
     - Fit: Resizes the image to fit within the width and height boundaries without cropping or distorting the image.
     The resulting image is assured to match one of the constraining dimensions,
     while the other dimension is altered to maintain the same aspect ratio of the input image.
     - Standard: Default/normal image mode. No changes to the ratio.
     */
    public enum ImageUrlMode : String {
		case resize		= "resize"
		case crop		= "crop"
		case fit		= "fit"
		case `default`	= "default"
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
    public func appendingAssetSize(_ size: CGSize, mode: ImageUrlMode = .default, heightParameterName : String = "h", widthParameterName : String = "w") -> URL? {
        guard var urlComponents = URLComponents(url: self, resolvingAgainstBaseURL: false) else { return nil }
        
        var queryItems:[URLQueryItem] = urlComponents.queryItems ?? []
        queryItems.append(URLQueryItem(name: widthParameterName, value: "\(Int(size.width * UIScreen.main.scale ))"))
        queryItems.append(URLQueryItem(name: heightParameterName, value: "\(Int(size.height * UIScreen.main.scale ))"))
        if mode != .default {
            queryItems.append(URLQueryItem(name: "mode", value: mode.rawValue))
        }
        urlComponents.queryItems = queryItems
        return urlComponents.url
    }
}
