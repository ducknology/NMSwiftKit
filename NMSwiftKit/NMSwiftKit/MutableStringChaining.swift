//
//  MutableStringChaining.swift
//  NMSwiftKit
//
//  Created by Billy Chan on 9/13/18.
//  Copyright © 2018 Billy Chan. All rights reserved.
//

import UIKit

public extension String {
    var attributed: NSAttributedString {
        return NSAttributedString(string: self)
    }
    
    var nsRange: NSRange {
        return NSRange(location: 0, length: self.utf16.count)
    }
}

public extension NSAttributedString {
    public var mutable: NSMutableAttributedString {
        return NSMutableAttributedString(attributedString: self)
    }
}

public extension NSMutableAttributedString {
    @discardableResult public func applyFont(_ font: UIFont) -> NSMutableAttributedString {
        self.applyAttributes(StringAttribute.font(font).attribute)
        return self
    }
    
    @discardableResult public func applyTextColor(_ color: UIColor) -> NSMutableAttributedString {
        self.applyAttributes(StringAttribute.textColor(color).attribute)
        return self
    }
    
    @discardableResult public func applyAttributes(_ attributes: [NSAttributedStringKey: Any]) -> NSMutableAttributedString {
        self.addAttributes(attributes, range: self.string.nsRange)
        return self
    }
}

public enum StringAttribute {
    case font(UIFont)
    case textColor(UIColor)
    
    public  var attribute: [NSAttributedStringKey: Any] {
        switch self {
        case let .font(font):
            return [NSAttributedStringKey.font: font]
        case let .textColor(color):
            return [NSAttributedStringKey.foregroundColor: color]
        }
    }
}
