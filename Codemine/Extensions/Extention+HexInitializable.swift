//
//  Extention+HexInitializable.swift
//  Codemine
//
//  Created by Andrei Hogea on 27/03/2018.
//  Copyright © 2018 Nodes. All rights reserved.
//

import Foundation

// MARK: Hex Initializable
#if os(OSX)
    import Cocoa
    typealias Color = NSColor
#else
    import UIKit
    typealias Color = UIColor
#endif

public protocol HexInitializable {
    static func fromHexString<T>(_ hexString: String) -> T?
}

extension Color: HexInitializable {
    
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
