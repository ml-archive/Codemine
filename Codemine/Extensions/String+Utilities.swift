//
//  String+utilities.swift
//  Codemine
//
//  Created by Style Theory on 14/10/19.
//  Copyright © 2019 Nodes. All rights reserved.
//

import Foundation

public extension String {
    func trimSpacing() -> String {
        return replacingOccurrences(of: " ", with: "")
    }
}
