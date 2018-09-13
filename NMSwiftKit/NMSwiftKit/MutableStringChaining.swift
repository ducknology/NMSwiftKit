//
//  MutableStringChaining.swift
//  NMSwiftKit
//
//  Created by Billy Chan on 9/13/18.
//  Copyright © 2018 Billy Chan. All rights reserved.
//

import UIKit

extension String {
    var attributed: NSAttributedString {
        return NSAttributedString(string: self)
    }
    
    var nsRange: NSRange {
        return NSRange(location: 0, length: self.utf16.count)
    }
}

extension NSAttributedString {
    var mutable: NSMutableAttributedString {
        return NSMutableAttributedString(attributedString: self)
    }
}

extension NSMutableAttributedString {
    @discardableResult func applyFont(_ font: UIFont) -> NSMutableAttributedString {
        self.applyAttributes(StringAttribute.font(font).attribute)
        return self
    }
    
    @discardableResult func applyTextColor(_ color: UIColor) -> NSMutableAttributedString {
        self.applyAttributes(StringAttribute.textColor(color).attribute)
        return self
    }
    
    @discardableResult func applyAttributes(_ attributes: [NSAttributedStringKey: Any]) -> NSMutableAttributedString {
        self.addAttributes(attributes, range: self.string.nsRange)
        return self
    }
}

enum StringAttribute {
    case font(UIFont)
    case textColor(UIColor)
    
    var attribute: [NSAttributedStringKey: Any] {
        switch self {
        case let .font(font):
            return [NSAttributedStringKey.font: font]
        case let .textColor(color):
            return [NSAttributedStringKey.foregroundColor: color]
        }
    }
}
