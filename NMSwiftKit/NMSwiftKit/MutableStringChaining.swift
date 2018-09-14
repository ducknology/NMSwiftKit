//
//  MutableStringChaining.swift
//  NMSwiftKit
//
//  Created by Billy Chan on 9/13/18.
//  Copyright © 2018 Billy Chan. All rights reserved.
//

import UIKit

public extension String {
    var mutableAttributed: NSMutableAttributedString {
        return NSMutableAttributedString(string: self)
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
        self.applyAttributes(StringAttribute.font(font))
        return self
    }
    
    @discardableResult public func applyTextColor(_ color: UIColor) -> NSMutableAttributedString {
        self.applyAttributes(StringAttribute.textColor(color))
        return self
    }
    
    @discardableResult public func applyAttributes(_ attributes: [NSAttributedStringKey: Any]) -> NSMutableAttributedString {
        self.addAttributes(attributes, range: self.string.nsRange)
        return self
    }
    
    @discardableResult public func applyLineSpacing(_ spacing: CGFloat) -> NSMutableAttributedString {
        self.applyAttributes(StringAttribute.lineSpacing(spacing))
        return self
    }
    
    @discardableResult public func appending(_ attrString: NSAttributedString) -> NSMutableAttributedString {
        self.append(attrString)
        return self
    }
}

public struct StringAttribute {
    static func font(_ font: UIFont) -> [NSAttributedStringKey: Any] {
        return [NSAttributedStringKey.font: font]
    }

    static func textColor(_ color: UIColor) -> [NSAttributedStringKey: Any] {
        return [NSAttributedStringKey.foregroundColor: color]
    }
    
    static func lineSpacing(_ linSpacing: CGFloat) -> [NSAttributedStringKey: Any] {
        return [NSAttributedStringKey.paragraphStyle: {
            let paragraphStyle = NSMutableParagraphStyle()
            paragraphStyle.lineSpacing = linSpacing
            return paragraphStyle
        }()]
    }
}
