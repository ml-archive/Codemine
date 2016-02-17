# Codemine

[![Travis](https://img.shields.io/travis/nodes-ios/Codemine.svg)](https://travis-ci.org/nodes-ios/Codemine)
[![Codecov](https://img.shields.io/codecov/c/github/nodes-ios/Codemine.svg)](https://codecov.io/github/nodes-ios/Codemine)
[![Carthage Compatible](https://img.shields.io/badge/Carthage-compatible-4BC51D.svg?style=flat)](https://github.com/Carthage/Carthage)
![Plaform](https://img.shields.io/badge/platform-iOS-lightgrey.svg)
[![GitHub license](https://img.shields.io/badge/license-MIT-blue.svg)](https://github.com/nodes-ios/Codemine/blob/master/LICENSE)

Codemine is a collection of extensions containing useful functions and syntactic sugar for your Swift project.



## 📦 Installation

### Carthage
~~~
github "nodes-ios/Codemine"
~~~

## Usage

### Application
```swift
let appName = Application.name             // CFBundleDisplayName : String
let appVersion = Application.version       // CFBundleShortVersionString : String
let appExecutable = Application.executable // CFBundleExecutable : String
let appBundle = Application.bundle         // CFBundleIdentifier : String
let appSchemes = Application.schemes       // CFBundleURLSchemes : [String]
let mainAppScheme = Application.mainScheme // CFBundleURLSchemes.first : String?
```

Gain easy access to main bundle information.

### CGRect
```swift
var rect = CGRect(x: 10, y: 10, width: 120, height: 100)
rect.x = 50
print(rect)	// outputs x:50, y:20, width: 120, height:100
rect.y = -10
print(rect)	// outputs x:50, y:-10, width: 120, height:100
let reversedRect = rect.rectByReversingSize()
print(reversedRect)	// outputs x:50, y:-10, width:100, height:120
```

### CGPoint
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

### Grand Central Dispatch

```swift
dispatch {
  // dispatch in main queue
}

dispatch(queue: .Background) {
  // dispatch in background queue
}

lazy var serialQueue = dispatch_queue_create("serialQueue", DISPATCH_QUEUE_SERIAL)
dispatch(queue: .Custom(serialQueue)) {
  // dispatch in a serial queue
}
```

Easy dispatching with grand central dispatch.
Support all the regular global queues: `Main`, `Interactive`, `Initiated`, `Utility`, `Background`.
And `.Custom()` for your own dispatch queues.

### NSError
```swift
let error = NSError(domain: domain, code: code, description: description)
```
instead of

```swift
let error = NSError(domain: domain, code: code, userInfo: [NSLocalizedDescriptionKey : description])
```

### NSURL
```swift
guard let url = NSURL(string: "https://example.com/image.png") else { return }
let size = CGSize(width: 512, height: 256)
let heightParameterName = "height"
let widthParameterName = "width"

let url2 = url.urlByAppendingAssetSize(size, mode: .Default, heightParameterName: heightParameterName, widthParameterName: widthParameterName)
print(url2.absoluteString)	// on an @2x screen: "https://example.com/image.png?width=1024&height=512"
```
This method appends the `size` multiplied by `UIScreen.mainScreen().scale` to an asset url so that the asset has the correct size to be shown on the screen.

### String
```swift
let camelCaseStr1 = "userId"
let camelCaseStr2 = "isUserActiveMemberOfCurrentGroup"
        
print(camelCaseStr1.camelCaseToUnderscore())	// "user_id"
print(camelCaseStr2.camelCaseToUnderscore())	// "is_user_active_member_of_current_group"
```
```swift
"email@example.com".isValidEmailAddress()	// true
"email.example.com".isValidEmailAddress()	// false
```

```swift
let str = "Hello world!"
let range = str.rangeFromString("e", toString: " w")	// Range(1..<7)
```

### UIColor

```swift
let red = UIColor(rgb: 0xFF0000)
```

### UIImage

```swift
let image = UIImage.imageFromColor(UIColor.redColor(), CGSize(width: 512, height: 256), cornerRadius:4.0)
```
Returns a UIImage filled with red color, of the specified size and with the specified corner radius

```swift
let image = UIImage.imageByEmbeddingIconIn(UIImage(named:"profilePhoto"), icon: UIImage(named:"favouriteIcon"))
```
Returns a UIImage composed by overlaying the icon on top of the first image.

### UIView
```swift
let view = UIView.viewWithNibNamed("customView")
```
Returns a view instantiated from the specified nib.

```swift
let view = UIView(frame: CGRect(x: 0, y: 0, width: 20, height: 20))
view.roundViewCorners(UIRectCorner.AllCorners, radius: 4.0)
```
Rounds the specified corners of a UIView to the specified radius.

### Then

```
let UIView().then {
  $0.backgroundColor = UIColor.blackColor()
}
```

## 👥 Credits
Made with ❤️ at [Nodes](http://nodesagency.com). 

Some functions & tweaks were borrowed from Hyper's [Sugar](https://github.com/hyperoslo/Sugar) 🙈.

## 📄 License
**Codemine** is available under the MIT license. See the [LICENSE](https://github.com/nodes-ios/Codemine/blob/master/LICENSE) file for more info.
