//
//  StringExtensions.swift
//  Codemine
//
//  Created by Marius Constantinescu on 11/02/16.
//  Copyright © 2016 Nodes. All rights reserved.
//

import Foundation

public extension String {
    /**
     Returns a snake_case String based on the current camelCase string. For example, userId will be transformed into user_id
     
     - returns: the snake_case String
     */
    public func camelCaseToUnderscore() -> String {
        var returnString = self
        
        let characterArray = Array(returnString.characters).map { (character) -> String in
            let inputCharacterString = String(character)
            let lowerCaseCharacterString = String(character).lowercaseString
            
            if inputCharacterString != lowerCaseCharacterString {
                return "_" + lowerCaseCharacterString
            }
            
            return inputCharacterString
        }
        
        returnString = characterArray.reduce("") {
            return $0 + $1
        }
        
        return returnString
    }
    
    /**
     Checks if the current string is a valid email address.
     
     - returns: true is the current string is a valid email address, false otherwise
     */
    public func isValidEmailAddress() -> Bool {

        let emailRegex = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,6}"
        let emailTest = NSPredicate(format:"SELF MATCHES %@", emailRegex)
        return emailTest.evaluateWithObject(self)
    }
}


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

