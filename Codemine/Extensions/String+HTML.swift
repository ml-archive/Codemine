//
//  String+HTML.swift
//  Codemine
//
//  Created by Chris on 28/06/2017.
//  Copyright © 2017 Nodes. All rights reserved.
//

import UIKit

private func htmlLabel(withText text: String) -> UILabel {
    let label = UILabel()
    label.numberOfLines = 0
    label.lineBreakMode = .byWordWrapping
    label.attributedText = stringFromHtml(string: text)

    return label
}

private func stringFromHtml(string: String) -> NSAttributedString? {
    do {
        let data = string.data(using: String.Encoding.utf8, allowLossyConversion: true)
        if let d = data {
            let str = try NSAttributedString(data: d,
                                             options: [NSDocumentTypeDocumentAttribute: NSHTMLTextDocumentType],
                                             documentAttributes: nil)
            return str
        }
    } catch {
    }
    return nil
}

extension String {
    public var attributedHTMLString: NSAttributedString? {
        return stringFromHtml(string: self)
    }
}
