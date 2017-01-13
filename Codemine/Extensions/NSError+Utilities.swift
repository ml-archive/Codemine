//
//  Errors.swift
//  Codemine
//
//  Created by Dominik Hádl on 14/02/16.
//  Copyright © 2016 Nodes. All rights reserved.
//

import Foundation


public extension NSError {
    /**
     Convenience initializer for an NSError
     
     - parameter domain:      The error domain—this can be one of the predefined NSError domains, or an arbitrary string describing a custom domain. domain must not be nil. 
     - parameter code:        The error code for the error.
     - parameter description: The description of the error. Corresponds to the `NSLocalizedDescriptionKey` in the 'userInfo' dictionary
     
     - returns: An NSError object initialized for domain with the specified error code and the description.
     */
    convenience init(domain: String, code: Int, description: String) {
        self.init(domain: domain, code: code, userInfo: [NSLocalizedDescriptionKey : description])
    }
}
