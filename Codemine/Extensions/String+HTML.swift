//
//  String+HTML.swift
//  Codemine
//
//  Created by Chris on 28/06/2017.
//  Copyright © 2017 Nodes. All rights reserved.
//

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
