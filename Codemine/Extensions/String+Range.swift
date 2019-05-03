//
//  String+Range.swift
//  Codemine
//
//  Created by Marius Constantinescu on 18/02/16.
//  Copyright © 2016 Nodes. All rights reserved.
//

import Foundation


public extension String {
    /**
     Checks if a range appears in a String.
     
     - parameter range: the range that is checked
     
     - returns: true if the string contains that range, false otherwise
     */
    private func contains(_ range: Range<Index>) -> Bool {
        if range.lowerBound < self.startIndex || range.upperBound > self.endIndex {
            return false
        }
        
        return true
    }
    
    enum RangeSearchType: Int {
        case leftToRight
        case rightToLeft
        case broadest
        case narrowest
    }
    
    /**
     Returns the range between two substrings, including the 2 substrings.
     
     - parameter string:     first substring
     - parameter toString:   second substring
     - parameter searchType: direction of search
     - parameter inRange:    the range of the string in which the search is performed. If nil, it will be done in the whole string.
     
     - returns: the range between the start of the first substring and the end of the last substring
     */
    func range(from fromString: String, toString: String, searchType: RangeSearchType = .leftToRight,  inRange: Range<Index>? = nil) -> Range<Index>? {
        let range = inRange ?? Range(uncheckedBounds: (lower: self.startIndex, upper: self.endIndex))
        if !contains(range) { return nil }
        
        guard let firstRange = self.range(of: fromString, options: NSString.CompareOptions(rawValue: 0), range: range, locale: nil) else { return nil }
        guard let secondRange = self.range(of: toString, options: NSString.CompareOptions(rawValue: 0), range: range, locale: nil) else { return nil }
        
        switch searchType {
        case .leftToRight:
             return firstRange.lowerBound..<secondRange.upperBound
        default:
            print("Other search options not yet implemented.")
        }
        
        return nil
    }
    
}
