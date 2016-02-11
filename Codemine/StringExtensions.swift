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

