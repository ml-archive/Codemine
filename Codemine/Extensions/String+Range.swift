//
//  String+Range.swift
//  Codemine
//
//  Created by Marius Constantinescu on 18/02/16.
//  Copyright © 2016 Nodes. All rights reserved.
//

import Foundation


public extension String {
    private var range: Range<Index> {
        return Range(start: self.startIndex, end: self.endIndex)
    }
    
    private func containsRange(range: Range<Index>) -> Bool {
        if range.startIndex < self.startIndex || range.endIndex > self.endIndex {
            return false
        }
        
        return true
    }
    
    public enum RangeSearchType: Int {
        case LeftToRight
        case RightToLeft
        case Broadest
        case Narrowest
    }
    
    /**
     Returns the range between two substrings, including the 2 substrings.
     
     - parameter string:     first substring
     - parameter toString:   second substring
     - parameter searchType: direction of search
     - parameter inRange:    the range of the string in which the search is performed. If nil, it will be done in the whole string.
     
     - returns: the range between the start of the first substring and the end of the last substring
     */
    public func rangeFromString(string: String, toString: String, searchType: RangeSearchType = .LeftToRight,  inRange: Range<Index>? = nil) -> Range<Index>? {
        let range = inRange ?? self.range
        if !containsRange(range) { return nil }
        
        guard let firstRange = self.rangeOfString(string, options: NSStringCompareOptions(rawValue: 0), range: range, locale: nil) else { return nil }
        guard let secondRange = self.rangeOfString(toString, options: NSStringCompareOptions(rawValue: 0), range: range, locale: nil) else { return nil }
        
        switch searchType {
        case .LeftToRight:
            return Range(start: firstRange.startIndex, end: secondRange.endIndex)
        default:
            print("Other search options not yet implemented.")
        }
        
        return nil
    }
    
}
