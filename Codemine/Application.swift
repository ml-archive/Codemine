// Copyright (c) 2015 Hyper Interaktiv AS
//
// Permission is hereby granted, free of charge, to any person obtaining
// a copy of this software and associated documentation files (the
// "Software"), to deal in the Software without restriction, including
// without limitation the rights to use, copy, modify, merge, publish,
// distribute, sublicense, and/or sell copies of the Software, and to
// permit persons to whom the Software is furnished to do so, subject to
// the following conditions:
//
// The above copyright notice and this permission notice shall be
// included in all copies or substantial portions of the Software.
//
// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
// EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
// MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.
// IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY
// CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT,
// TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE
// SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.

import Foundation

public struct Application {
    
    fileprivate static func getString(_ key: String) -> String {
        guard let infoDictionary = Bundle.main.infoDictionary,
            let value = infoDictionary[key] as? String
            else { return "" }
        
        return value
    }
    
    public static var name: String = {
        return Application.getString("CFBundleDisplayName")
    }()
    
    public static var version: String = {
        return Application.getString("CFBundleShortVersionString")
    }()
    
    public static var build: String = {
        return Application.getString("CFBundleVersion")
    }()
    
    public static var executable: String = {
        return Application.getString("CFBundleExecutable")
    }()
    
    public static var bundle: String = {
        return Application.getString("CFBundleIdentifier")
    }()
    
    public static var schemes: [String] = {
        guard let infoDictionary = Bundle.main.infoDictionary,
            let urlTypes = infoDictionary["CFBundleURLTypes"] as? [AnyObject],
            let urlType = urlTypes.first as? [String : AnyObject],
            let urlSchemes = urlType["CFBundleURLSchemes"] as? [String]
            else { return [] }
        
        return urlSchemes
    }()
    
    public static var mainScheme: String? = {
        return schemes.first
    }()
    
}
