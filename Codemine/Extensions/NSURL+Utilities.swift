//
//  NSURL+Utilities.swift
//  Codemine
//
//  Created by Marius Constantinescu on 18/02/16.
//  Copyright © 2016 Nodes. All rights reserved.
//

import Foundation
import CoreGraphics
#if os(iOS) || os(tvOS)
import UIKit
#else
import AppKit
#endif

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
    enum ImageUrlMode : String {
		case resize		= "resize"
		case crop		= "crop"
		case fit		= "fit"
		case `default`	= "default"
    }
	
    /**
     Adds height, width and mode paramters to an url. To be used when fetching an image from a CDN, for example.
     Choose the `size` and the `mode` for the image url to define how an image will be provided from the backend.
     
     - parameters:
        - size: Set `size` as `CGSize` to define the size of the image that will be provided.
        - mode: Select a mode from predefined `ImageUrlMode` to set up a mode and define how an image will be provided.
        - heightParameterName: the name of the height paramter. Default is 'h'
        - widthParameterName: the name of the width paramter. Default is 'h'
     - returns: `URL` as a `NSURL`.
     */
    func appendingAssetSize(_ size: CGSize, mode: ImageUrlMode = .default, heightParameterName : String = "h", widthParameterName : String = "w") -> URL? {
        guard var urlComponents = URLComponents(url: self, resolvingAgainstBaseURL: false) else { return nil }
        
        #if os(iOS) || os(tvOS)
        let screenScale = UIScreen.main.scale
        #else
        let screenScale = NSScreen.main?.backingScaleFactor ?? 1.0
        #endif
        
        var queryItems:[URLQueryItem] = urlComponents.queryItems ?? []
        queryItems.append(URLQueryItem(name: widthParameterName, value: "\(Int(size.width * screenScale ))"))
        queryItems.append(URLQueryItem(name: heightParameterName, value: "\(Int(size.height * screenScale ))"))
        if mode != .default {
            queryItems.append(URLQueryItem(name: "mode", value: mode.rawValue))
        }
        urlComponents.queryItems = queryItems
        return urlComponents.url
    }

    /**
     Finds the first value for a URL parameter in a `URL`
     - parameters:
        - name: the URL parameter to look for
     - returns: the first value found for `name` or nil if no value was found
     */
    func value(forParameter name: String) -> String? {
        guard let urlComponents = URLComponents(url: self, resolvingAgainstBaseURL: true),
            let queryItems = urlComponents.queryItems else {
                return nil
        }
        let items = queryItems.filter({ $0.name == name })
        return items.first?.value
    }
    
    /**
     Appends queryParameters to a `URL`
     - parameters:
        - queryParameters: a `String` : `String` dictionary containing the queryParameters to append
     - returns: a new `URL` instance with the appended queryParameters or nil if the appending failed
     */
    func append(queryParameters: [String: String]) -> URL? {
        guard var urlComponents = URLComponents(url: self, resolvingAgainstBaseURL: true) else {
            return nil
        }
        
        let urlQueryItems = queryParameters.map{
            return URLQueryItem(name: $0, value: $1)
        }
        urlComponents.queryItems = urlQueryItems
        return urlComponents.url
    }
    
    /// Changes a value for a queryParameter in a given URL
    ///
    /// - Parameters:
    ///   - url: The `URL` that you want to change a queryParemeter in
    ///   - withName: The `String` representation of the name of the queryParameter you want to change the value of
    ///   - toValue: The `String` representation of the new value for the queryParameter
    /// - Returns: A new `URL` instance with a changed queryParameter value, for the first param that matches the input, or nil if the change failed
    func changeQueryParamValue(withName param: String, to newValue: String) -> URL? {

        if self.value(forParameter: param) != nil {
            if
                var component = URLComponents(url: self, resolvingAgainstBaseURL: false),
                var queryItems = component.queryItems,
                let index = queryItems.firstIndex(where: {$0.name == param})
            {
                queryItems[index].value = newValue
                component.queryItems = queryItems
                
                return component.url
            }
        }
        return nil
    }
    
}
