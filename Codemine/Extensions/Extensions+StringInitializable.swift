//
//  Extensions.swift
//  Serializable
//
//  Created by Chris Combs on 16/02/16.
//  Copyright © 2016 Nodes. All rights reserved.
//

import Foundation

// MARK: - Protocols -
// MARK: String Initializable

public protocol StringInitializable {
    static func fromString<T>(_ string: String) -> T?
    func stringRepresentation() -> String
}

extension URL: StringInitializable {
    public static func fromString<T>(_ string: String) -> T? {
        return self.init(string: string) as? T
    }
    
    public func stringRepresentation() -> String {
        return self.absoluteString
    }
}

extension Date: StringInitializable {
    static fileprivate let internalDateFormatter = DateFormatter()
    static fileprivate let allowedDateFormats = ["yyyy-MM-dd'T'HH:mm:ssZZZZZ", "yyyy-MM-dd'T'HH:mm:ss", "yyyy-MM-dd"]
    static public var customDateFormats: [String] = []
    
    public static func fromString<T>(_ string: String) -> T? {
        for format in allowedDateFormats + customDateFormats {
            internalDateFormatter.dateFormat = format
            if let date = internalDateFormatter.date(from: string) as? T {
                return date
            }
        }
        
        return nil
    }
    
    public func stringRepresentation() -> String {
        Date.internalDateFormatter.dateFormat = Date.allowedDateFormats.first
        return Date.internalDateFormatter.string(from: self)
    }
}




