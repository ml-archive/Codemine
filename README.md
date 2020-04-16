# Codemine
[![CircleCI](https://circleci.com/gh/nodes-ios/Codemine.svg?style=shield)](https://circleci.com/gh/nodes-ios/Codemine)
[![Codecov](https://img.shields.io/codecov/c/github/nodes-ios/Codemine.svg)](https://codecov.io/github/nodes-ios/Codemine)
[![CocoaPods](https://img.shields.io/cocoapods/v/Codemine.svg)](https://cocoapods.org/pods/Codemine)
[![Carthage Compatible](https://img.shields.io/badge/Carthage-compatible-4BC51D.svg?style=flat)](https://github.com/Carthage/Carthage)
![Swift Package Manager](https://img.shields.io/badge/SPM-compatible-brightgreen.svg)
![Plaform](https://img.shields.io/badge/platform-iOS-lightgrey.svg)
[![GitHub license](https://img.shields.io/badge/license-MIT-blue.svg)](https://github.com/nodes-ios/Codemine/blob/master/LICENSE)
[![Readme Score](http://readme-score-api.herokuapp.com/score.svg?url=nodes-ios/codemine)](http://clayallsopp.github.io/readme-score?url=nodes-ios/codemine)

Codemine is a collection of extensions containing useful functions and syntactic sugar for your Swift project.


## Table of contents
**Using Codemine as a library**

- [Requirements](#requirements)  
- [Installation](#installation)  

**Browsing the individual code snippets and usages.**

- [Application](#application)
- [CGPoint](#cgpoint)
- [CGRect](#cgrect)
- [Dispatch time](#dispatch-time)
- [Hex initializable](#hex-initializable)
- [NSError](#nserror)
- [String](#string)
- [String initializable](#string-initializable)
- [UIImage](#uiimage)
- [UIView](#uiview)
- [URL](#url)
- [URLSession](#urlsession)

**Other**

- [Credits](#credits)
- [License](#license)

## Requirements

* iOS 8.0+
* Swift 3.0+


## Installation

### CocoaPods

If you are using CocoaPods add this text to your Podfile and run `pod install`. 

~~~
pod 'Codemine', '~>1.0.0'

# Swift 2.3
pod 'Codemine', '~>0.2.5'

# Swift 2.2
pod 'Codemine', '~>0.2.2'
~~~

### Carthage
~~~
github "nodes-ios/Codemine" ~> 1.0

# Swift 2.3
github "nodes-ios/Codemine" == 0.2.5

# Swift 2.2
github "nodes-ios/Codemine" == 0.2.2
~~~

## Application
### Description
Contains easily accessible variables for the application's:  

- Display name   
- Version number   
- Build number   
- Executable name   
- Bundle identifier   
- Available schemes   
- Main scheme   

### Code
```swift
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
```
[See in Codemine](https://github.com/nodes-ios/Codemine/blob/master/Codemine/Application.swift)
### 💻 Usage
```swift
let appName = Application.name             // CFBundleDisplayName : String
let appVersion = Application.version       // CFBundleShortVersionString : String
let appExecutable = Application.executable // CFBundleExecutable : String
let appBundle = Application.bundle         // CFBundleIdentifier : String
let appSchemes = Application.schemes       // CFBundleURLSchemes : [String]
let mainAppScheme = Application.mainScheme // CFBundleURLSchemes.first : String?
```

## CGPoint
### Description
Contains methods:

- `isCloseTo` which checks if a CGPoint is close to another CGPoint within a given tolerance.

Constains operators:

- `+` which summerises 2 `CGPoints` into 1
- `*` which multiplies 2 `CGPoints` with each other to 1 `CGPoint`
- `*` which multiplies a `CGPoint`'s `x` and `y` value with a `CGFloat` 
- `-` which subtracts the right `CGPoint` from the left `CGPoint`
- `/` which devides a `CGPoint`'s `x` and `y` value by a `CGFloat`
- `/` which devides 2 `CGPoints` by each other to 1 `CGPoint`

### Code
#### Extension
```swift
import CoreGraphics

public extension CGPoint {
    /**
     Check if a `CGPoint` is close to another `CGPoint`.
     There is a tolerance that defines the range that is tolerated to call it close to another `CGPoint`.
     If the actual point is close to the `point` from the parameter it will return true.
     
     - Parameters:
        - point: The `CGPoint` that will be checked if it is close to the actual `CGPoint`.
        - tolerance: Defines what range is tolerated to be close to the other `point`.
     
     - Returns: `Boolean` - if close to return true, else false.
     */
    func isCloseTo(_ point: CGPoint, tolerance: CGFloat) -> Bool {
        let xIsClose = self.x <= point.x + tolerance && self.x >= point.x - tolerance
        let yIsClose = self.y <= point.y + tolerance && self.y >= point.y - tolerance
        return xIsClose && yIsClose
    }
}
```
[See in Codemine](https://github.com/nodes-ios/Codemine/blob/master/Codemine/Extensions/CGPoint%2BUtilities.swift)
#### Operators
```swift
import CoreGraphics

/// Add Operator `+` for two `CGPoints` to summerise them to one `CGPoint`.
public func + (left: CGPoint, right: CGPoint) -> CGPoint {
    return CGPoint(x: left.x + right.x, y: left.y + right.y)
}

/// Add Operator `*` for two `CGPoints` to multiply both with each other to one `CGPoint`.
public func * (left: CGPoint, right: CGPoint) -> CGPoint {
    return CGPoint(x: left.x * right.x, y: left.y * right.y)
}

/// Add Operator `*` to multiply a CGPoint to a CGFloat to get a CGPoint.
public func * (left: CGPoint, right: CGFloat) -> CGPoint {
    return CGPoint(x: left.x * right, y: left.y * right)
}

/// Add Operator `-` for two `CGPoints` subtract the `right` from the `left` `CGPoint`.
public func - (left: CGPoint, right: CGPoint) -> CGPoint {
    return CGPoint(x: left.x - right.x, y: left.y - right.y)
}

/// Add Operator `/` to devide a `CGPoints` by the value of a `CGFloat`.
public func / (left: CGPoint, right: CGFloat) -> CGPoint {
    return CGPoint(x: left.x / right, y: left.y / right)
}

/// Add Operator `/` for two `CGPoints`. The left will be devided by the right one.
public func / (left: CGPoint, right: CGPoint) -> CGPoint {
    return CGPoint(x: left.x / right.x, y: left.y / right.y)
}
```
[See in Codemine](https://github.com/nodes-ios/Codemine/blob/master/Codemine/Operators.swift)
### 💻 Usage
```swift
let point1 = CGPoint(x: 5, y: 5)
let point2 = CGPoint(x: 5, y: 6)
print(point1.isCloseTo(point2, tolerance: 1))	// true
print(point1.isCloseTo(point2, tolerance: 0.5))	// false
print(point1+point2)	// (10, 11)
print(point1*point2)	// (25, 30)
print(point1*2)			// (10, 10)
print(point1-point2)	// (0, -1)
print(point1/point2)	// (1, 0.83)
print(point1/5)			// (1, 1)
```

## CGRect
### Description
Contains variables:

- `y` which returns and sets `origin.y`
- `x` which returns and sets `origin.x`
- `reversingSize` which returns a `CGRect` with height and width swapped

### Code
```swift
import CoreGraphics

public extension CGRect {
    /// Getter & Setter for a `CGRect`'s  `origin.y`
    public var y: CGFloat {
        set {
            self = CGRect(origin: CGPoint(x: origin.x, y: newValue), size: size)
        }
        get {
            return self.origin.y
        }
    }
    
    /// Getter & Setter for a `CGRect`s `origin.x`
    public var x: CGFloat {
        set {
            self = CGRect(origin: CGPoint(x: newValue, y: origin.y), size: size)
        }
        get {
            return self.origin.x
        }
    }
    
    /**
     Reverses the width and height of a 'CGRect'
     
     - returns: a new CGRect with the width and height reversed to those of the current one
     */
	public var reversingSize: CGRect {
        return CGRect(origin: origin, size: CGSize(width: height, height: width))
    }
}
```
[See in Codemine](https://github.com/nodes-ios/Codemine/blob/master/Codemine/Extensions/CGRect%2BUtilities.swift)
### 💻 Usage
```swift
var rect = CGRect(x: 10, y: 10, width: 120, height: 100)
rect.x = 50
print(rect)	// outputs x:50, y:20, width: 120, height:100
rect.y = -10
print(rect)	// outputs x:50, y:-10, width: 120, height:100
let reversedRect = rect.reversingSize
print(reversedRect)	// outputs x:50, y:-10, width:100, height:120
```

## CGSize
### Description
Contains operators:

- `+` which summerises both `CGSizes` into 1

### Code
```swift
/// Add Operator `+` for two `CGSizes` to summerise both to one `CGSize`.
public func + (left: CGSize, right: CGSize) -> CGSize {
    return CGSize(width: left.width + right.width, height: left.height + right.height)
}
```
[See in Codemine](https://github.com/nodes-ios/Codemine/blob/master/Codemine/Operators.swift)
### 💻 Usage
```swift
var size = CGSize(width: 5, height: 10)
var size2 = CGSize(width: 10, height: 20)

print(size)			// (5.0, 10.0)
print(size2)		// (10.0, 20.0)
print(size+size2)	// (15.0, 30.0)
```

## Dispatch time
### Description
Contains initializers:

- `init(integerLiteral:)` which adds the given value `Int` as a delay in seconds
- `init(floatLiteral:` which adds the given `Double` as a delay in seconds and fractions of seconds

### Code
```swift
// Credits for this go to Russ Bishop http://www.russbishop.net/quick-easy-dispatchtime

extension DispatchTime: ExpressibleByIntegerLiteral {
    public init(integerLiteral value: Int) {
        self = DispatchTime.now() + .seconds(value)
    }
}

extension DispatchTime: ExpressibleByFloatLiteral {
    public init(floatLiteral value: Double) {
        self = DispatchTime.now() + .milliseconds(Int(value * 1000))
    }
}
```
[See in Codemine](https://github.com/nodes-ios/Codemine/blob/master/Codemine/Extensions/DispatchTime%2BUtilities.swift)
### 💻 Usage
```swift
DispatchQueue.main.asyncAfter(deadline: 5) { /* ... */ }
```

## Hex initializable
### Description
Contains methods:

- `fromHexString(hexString: String) -> String` which converts a hex string to a usable UIColor.

### Code
```swift
import UIKit

public protocol HexInitializable {
    static func fromHexString<T>(_ hexString: String) -> T?
}

extension UIColor: HexInitializable {
    
    public static func fromHexString<T>(_ hexString: String) -> T? {
        let hex = hexString.trimmingCharacters(in: CharacterSet.alphanumerics.inverted)
        var int = UInt32()
        let a, r, g, b: UInt32
        
        guard Scanner(string: hex).scanHexInt32(&int) else {
            return nil
        }
        
        switch hex.count {
        // RGB (12-bit)
        case 3:
            (a, r, g, b) = (255, (int >> 8) * 17, (int >> 4 & 0xF) * 17, (int & 0xF) * 17)
        // RRGGBB (24-bit)
        case 6:
            (a, r, g, b) = (255, int >> 16, int >> 8 & 0xFF, int & 0xFF)
        // ARGB (32-bit)
        case 8:
            (a, r, g, b) = (int >> 24, int >> 16 & 0xFF, int >> 8 & 0xFF, int & 0xFF)
        default:
            return nil
        }
        
        return self.init(red: CGFloat(r) / 255,
                         green: CGFloat(g) / 255,
                         blue: CGFloat(b) / 255,
                         alpha: CGFloat(a) / 255) as? T
    }
}

```
[See in Codemine](https://github.com/nodes-ios/Codemine/blob/master/Codemine/Extensions/Extention%2BHexInitializable.swift)
### 💻 Usage
```swift
var color: UIColor? = UIColor.fromHexString("7353BA")
```

## NSError
### Description
Contains convenience initializers:

- `init(domain: String, code: Int, description: String)` which facilitates the initialization on a NSError object.

### Code
```swift
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
```
[See in Codemine](https://github.com/nodes-ios/Codemine/blob/master/Codemine/Extensions/NSError%2BUtilities.swift)
### 💻 Usage
```swift
let error = NSError(domain: domain, code: code, description: description)
```
Instead of

```swift
let error = NSError(domain: domain, code: code, userInfo: [NSLocalizedDescriptionKey : description])
```

## String
### Description
Contains variables:

- `isValidEmailAddress` which returns true if the string conforms to the email Regex
- `attributedHTMLString` which returns the attributed HTML string(from stringFromHtml) for the current String

Contains methods:

- `camelCaseToUnderscore` which turns a camelCasedString to a snake_cased_string
- `range(fromString: String, toString)` which returns the range between 2 given strings.
- `stringFromHtml(string: String)` which takes an HTML string and returns an Attributes string with the HTML attributes.
 
### Code
#### General
```swift
public extension String {
    /**
     Returns a snake_case String based on the current camelCase string. For example, userId will be transformed into user_id
     
     - returns: the snake_case String
     */
    public func camelCaseToUnderscore() -> String {
        var returnString = self
        
        let characterArray = Array(returnString.characters).map { (character) -> String in
            let inputCharacterString = String(character)
            let lowerCaseCharacterString = String(character).lowercased()
            
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
    public var isValidEmailAddress: Bool {
        
        let emailRegex = "\\A[A-Za-z0-9!#$%&'*+/=?^_`{|}~-]+(?:\\.[A-Za-z0-9!#$%&'*+/=?^_`{|}~-]+)*@(?:[A-Za-z0-9](?:[A-Za-z0-9-]*[A-Za-z0-9])?\\.)+[A-Za-z0-9](?:[A-Za-z0-9-]*[A-Za-z0-9])?\\z"
        let emailTest = NSPredicate(format:"SELF MATCHES %@", emailRegex)
        return emailTest.evaluate(with: self)
    }
}
```
[See "CamelCaseToUnderscore" in Codemine](https://github.com/nodes-ios/Codemine/blob/master/Codemine/Extensions/String%2BCaseConverter.swift)  
[See "isValidEmailAddress" in Codemine](https://github.com/nodes-ios/Codemine/blob/master/Codemine/Extensions/String%2BEmailValidation.swift)
#### Range
```swift
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
    
    public enum RangeSearchType: Int {
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
    public func range(from fromString: String, toString: String, searchType: RangeSearchType = .leftToRight,  inRange: Range<Index>? = nil) -> Range<Index>? {
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
```
[See in Codemine](https://github.com/nodes-ios/Codemine/blob/master/Codemine/Extensions/String%2BRange.swift)
#### HTML
```swift
import UIKit

public func stringFromHtml(string: String) -> NSAttributedString? {
    do {
        let data = string.data(using: String.Encoding.utf8, allowLossyConversion: true)
        if let d = data {
            let str = try NSAttributedString(data: d,
                                             options: [
                                                NSAttributedString.DocumentReadingOptionKey.documentType: NSAttributedString.DocumentType.html,
                                                NSAttributedString.DocumentReadingOptionKey.characterEncoding: String.Encoding.utf8.rawValue],
                                             documentAttributes: nil)
            return str
        }
    } catch {
        print(error)
    }
    return nil
}

extension UILabel {
    public convenience init(htmlString: String) {
        self.init()
        numberOfLines = 0
        lineBreakMode = .byWordWrapping
        attributedText = htmlString.attributedHTMLString
    }
}

extension String {
    public var attributedHTMLString: NSAttributedString? {
        return stringFromHtml(string: self)
    }
}
```
[See in Codemine](https://github.com/nodes-ios/Codemine/blob/master/Codemine/Extensions/String%2BHTML.swift)
### 💻 Usage
#### General
```swift
let camelCaseStr1 = "userId"
let camelCaseStr2 = "isUserActiveMemberOfCurrentGroup"

print(camelCaseStr1.camelCaseToUnderscore())	// "user_id"
print(camelCaseStr2.camelCaseToUnderscore())	// "is_user_active_member_of_current_group"

"email@example.com".isValidEmailAddress()	// true
"email.example.com".isValidEmailAddress()	// false
```
#### Range
```swift
let str = "Hello world!"
let range = str.range(from: "e", toString: " w")	// Range(1..<7)
```
#### HTML
```swift
let htmlString = """
<h1>Lorem ipsum dolor sit amet, consectetur adipisicing elit</h1>

<p>Sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.</p>

<p>Sed ut perspiciatis, unde omnis iste natus error sit voluptatem accusantium doloremque laudantium, totam rem aperiam eaque ipsa, quae ab illo inventore veritatis et quasi architecto beatae vitae dicta del veritas.</p>
"""

// Initialize new attributed string
let attributedString = stringFromHtml(string: htmlString)

// Access attributed string from original
print(htmlString.attributedHTMLString)

// Initialize label with html string
let attributedLabel = UILabel(htmlString: htmlString)
```


## String initializable
### Description
A protocol that contains methods:

- `fromString<T>(string: String) -> T?` which should initialize the conformed class using a `String`
- `stringRepresentation() -> String` which returns a `String` representation of the conformed class.


Contains extensions to `URL` and `Date` to get a `URL` or `Date` from a `String` and get its `String` representation.
### Code

```swift
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
```
[See in Codemine](https://github.com/nodes-ios/Codemine/blob/master/Codemine/Extensions/Extensions%2BStringInitializable.swift)
### 💻 Usage
```swift
let urlFromString: URL? = URL.fromString("https://www.google.com")

print(urlFromString?.stringRepresentation())          // Optional("https://www.google.com")

let dateFromString: Date? = Date.fromString("2019-04-15")

print(dateFromString?.stringRepresentation())         // Optional("2019-04-15T00:00:00+02:00")
```

## UIImage
### Description
Contains initializers:
 
- `init(color: UIColor, size: CGSize, cornerRadius: CGFloat)` which initializes a `UIImage` with a given size, filled with the given color.

Contains variables:

- `rotationCorrected` which corrects the orientation of the `UIImage`

Contains methods:

- `embed(icon: UIImage, inImage: UIImage) -> UIImage` which embeds the `icon` ontop of the given `image`

### Code
```swift
import UIKit

public extension UIImage {
    /**
     Create an `UIImage` with specified background color, size and corner radius.
     
     Parameter `color` is used for the background color,
     parameter `size` to set the size of the the holder rectangle,
     parameter `cornerRadius` for setting up the rounded corners.
     
     - Parameters:
        - color: The background color.
        - size: The size of the image.
        - cornerRadius: The corner radius.
     
     - Returns: A 'UIImage' with the specified color, size and corner radius.
     */
    
    convenience init(color: UIColor, size: CGSize, cornerRadius: CGFloat) {
        self.init()
        
        /// The base rectangle of the image.
        let rect = CGRect(x: 0, y: 0, width: size.width, height: size.height)
        UIGraphicsBeginImageContext(rect.size)
        
        /// The graphics context of the image.
        let context = UIGraphicsGetCurrentContext()
        context?.setFillColor(color.cgColor)
        context?.fill(rect)
        
        /// Image that will be retured.
        var image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        UIGraphicsBeginImageContext(size)
        
        UIBezierPath(roundedRect: rect, cornerRadius:cornerRadius).addClip()
        image?.draw(in: rect)
        
        image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
    }
    
    
    /**
     Embed an icon/image on top of a background image.
     
     `image` will be the background and `icon` is the image that will be on top of `image`.
     The `UIImage` that is set with the parameter `icon` will be centered on `image`.
     
     - Parameters:
        - icon: The embedded image that will be on top.
        - image: The background image.
     - Returns: The combined image as `UIImage`.
     */
    public class func embed(icon: UIImage, inImage image: UIImage ) -> UIImage? {
        let newSize = CGSize(width: image.size.width, height: image.size.height)
        UIGraphicsBeginImageContextWithOptions(newSize, false, 0.0)
        
        image.draw(in: CGRect(x: 0,y: 0,width: newSize.width,height: newSize.height))
        
        // Center icon
        icon.draw(in: CGRect(x: image.size.width/2 - icon.size.width/2, y: image.size.height/2 - icon.size.height/2, width: icon.size.width, height: icon.size.height), blendMode:CGBlendMode.normal, alpha:1.0)
        
        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        return newImage
    }
    
    /**
     Corrects the rotation/orientation of an image.
     When an image inadvertently was taken with the wrong orientation, this function will correct the rotation/orientation again.
     
     - Returns: The orientation corrected image as an `UIImage`.
     */
	public var rotationCorrected: UIImage? {
        
        UIGraphicsBeginImageContextWithOptions(self.size, false, self.scale)
        self.draw(in: CGRect(origin: CGPoint.zero, size: self.size))
        let normalizedImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return normalizedImage
    }
}
```
[See in Codemine](https://github.com/nodes-ios/Codemine/blob/master/Codemine/Extensions/UIImage%2BUtilities.swift)
### 💻 Usage

```swift
let image = UIImage(color: UIColor.red, CGSize(width: 512, height: 256), cornerRadius:4.0)
```
Returns a `UIImage` filled with red color, of the specified size and with the specified corner radius

```swift
let image = UIImage.embed(icon: UIImage(named:"favouriteIcon"), inImage: UIImage(named:"profilePhoto"))
```
Returns a `UIImage` composed by overlaying the icon on top of the first image.

## UIView
### Description
Contains methods:

- `from<T>(nibWithName: String) -> T?` which returns `UIView` initialized from a nib with the given nibName
- `roundViewCorners(corners: UIRectCorner, radius: CGFloat)` which rounds the current views given corners using the `layer.mask` approach

### Code
```swift
import UIKit

public extension UIView {
    /**
     Assign a `nibName` to a UIView.
     Later on you can call this `UIView` by its `nibName`.
     
     - Parameter name: The name that the UIView will get as its `name` assigned as a `String`.
     - Returns: `Generics type`.
     */
    public static func from<T>(nibWithName:String) -> T? {
        let view = UINib(nibName: nibWithName, bundle: nil).instantiate(withOwner: nil, options: nil).first as? T
        return view
    }
    
    /**
     Rounded corners for a `UIView`.
     
     - Parameters:
        - corners: Defines which corners should be rounded.
        - radius: Defines the radius of the round corners as a `CGFloat`.
     */
    public func roundViewCorners(_ corners:UIRectCorner, radius: CGFloat) {
        let path = UIBezierPath(roundedRect: self.bounds, byRoundingCorners: corners, cornerRadii: CGSize(width: radius, height: radius))
        let mask = CAShapeLayer()
        mask.path = path.cgPath
        self.layer.mask = mask
    }
}
```
[See in Codemine](https://github.com/nodes-ios/Codemine/blob/master/Codemine/Extensions/UIView%2BUtilities.swift)
### 💻 Usage
```swift
let view = UIView.from(nibWithName("customView"))
```
Returns a view instantiated from the specified nib.

```swift
let view = UIView(frame: CGRect(x: 0, y: 0, width: 20, height: 20))
view.roundViewCorners(UIRectCorner.allCorners, radius: 4.0)
```
Rounds the specified corners of a `UIView` to the specified radius.

## URL
### Description
Contains methods:

- `appendingAssetSize(size: CGSize, mode: ImageUrlMode, heightParameterName: String, widthParameterName: String) -> URL?` which Adds the height, wifth and mode parameters to an URL
- `value(forParameter: String) -> String?` which finds the first value for a URL parameter in a `URL`
- `append(queryParameters: [String: String]) -> URL?` which appends the given parameters to the `URL`

### Code
```swift
import CoreGraphics
import UIKit

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
    public enum ImageUrlMode : String {
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
    public func appendingAssetSize(_ size: CGSize, mode: ImageUrlMode = .default, heightParameterName : String = "h", widthParameterName : String = "w") -> URL? {
        guard var urlComponents = URLComponents(url: self, resolvingAgainstBaseURL: false) else { return nil }
        
        var queryItems:[URLQueryItem] = urlComponents.queryItems ?? []
        queryItems.append(URLQueryItem(name: widthParameterName, value: "\(Int(size.width * UIScreen.main.scale ))"))
        queryItems.append(URLQueryItem(name: heightParameterName, value: "\(Int(size.height * UIScreen.main.scale ))"))
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
    public func value(forParameter name: String) -> String? {
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
    public func append(queryParameters: [String: String]) -> URL? {
        guard var urlComponents = URLComponents(url: self, resolvingAgainstBaseURL: true) else {
            return nil
        }
        
        let urlQueryItems = queryParameters.map{
            return URLQueryItem(name: $0, value: $1)
        }
        urlComponents.queryItems = urlQueryItems
        return urlComponents.url
    }
}
```
[See in Codemine](https://github.com/nodes-ios/Codemine/blob/master/Codemine/Extensions/NSURL%2BUtilities.swift)
### 💻 Usage
```swift
guard let url = NSURL(string: "https://example.com/image.png") else { return }
let size = CGSize(width: 512, height: 256)
let heightParameterName = "height"
let widthParameterName = "width"

let url2 = url.appendingAssetSize(size, mode: .default, heightParameterName: heightParameterName, widthParameterName: widthParameterName)
print(url2.absoluteString)	// on an @2x screen: "https://example.com/image.png?width=1024&height=512"
```
This method appends the `size` multiplied by `UIScreen.main.scale` to an asset url so that the asset has the correct size to be shown on the screen.


## URLSession
### Description
Contains methods:

- `decode<Value: Swift.Decodable>(requestCompletion: (Data?, Error?)) -> DResult<Value>` which adds a handler that attempts to parse the result of the request into a `Decodable`
- `decode<Value: Swift.Decodable>(_ completion: @escaping ((DResult<Value>) -> Void)) -> ((Data?, URLResponse?, Error?) -> Void)` which adds a handler that attempts to parse the requst of the request into a `Decodable`

### Code
```swift
// Decoded Result
public enum DResult<Value> {
    case success(Value)
    case successWithError(Value, Error)
    case failure(Error)
}

public extension URLSession {
    
    /**
     Adds a handler that attempts to parse the result of the request into a **Decodable**
     
     - parameter requestCompletion: The URLSession.dataTask completion
     
     - returns: The Decoded Result (DResult)
     */
    public func decode<Value: Swift.Decodable>(requestCompletion: (Data?, Error?)) -> DResult<Value> {
        switch requestCompletion {
        case (.some(let data), .some(let error)):
            do {
                let decodedData = try JSONDecoder().decode(Value.self, from: data)
                return .successWithError(decodedData, error)
            } catch let decodeError {
                return .failure(decodeError)
            }
        case (.some(let data), .none):
            do {
                let decodedData = try JSONDecoder().decode(Value.self, from: data)
                return .success(decodedData)
            } catch let decodeError {
                return .failure(decodeError)
            }
        case (.none, .some(let error)):
            return .failure(error)
            
        case (.none, .none):
            let fallBackError = NSError(domain: "", code: 0, userInfo: [NSLocalizedDescriptionKey: "Data was not retrieved from request"]) as Error
            return .failure(fallBackError)
        }
    }
    
    /**
     Adds a handler that attempts to parse the result of the request into a **Decodable**
     
     - parameter completion: A closure that is invoked when the request is finished, containting the desired DataModel to be returned
     
     - returns: The URLSession.dataTask completion
     */
    public func decode<Value: Swift.Decodable>(_ completion: @escaping ((DResult<Value>) -> Void)) -> ((Data?, URLResponse?, Error?) -> Void) {
        return { (data, _, error) in
            DispatchQueue.main.async {
                completion(self.decode(requestCompletion: (data, error)))
            }
        }
    }
}
```
[See in Codemine](https://github.com/nodes-ios/Codemine/blob/master/Codemine/Extensions/URLSession%2BCodable.swift)
## Credits
Made with ❤️ at [Nodes](http://nodesagency.com).

`Application` and `Then` were borrowed from Hyper's [Sugar](https://github.com/hyperoslo/Sugar) 🙈.

The `DispatchTime` extensions are [Russ Bishop's idea](http://www.russbishop.net/quick-easy-dispatchtime) 🙈.


## License
**Codemine** is available under the MIT license. See the [LICENSE](https://github.com/nodes-ios/Codemine/blob/master/LICENSE) file for more info.
