//
//  Errors.swift
//  Codemine
//
//  Created by Dominik Hádl on 14/02/16.
//  Copyright © 2016 Nodes. All rights reserved.
//

import Foundation


public extension NSError {
    convenience init(domain: String, code: Int, description: String) {
        self.init(domain: domain, code: code, userInfo: [NSLocalizedDescriptionKey : description])
    }
}