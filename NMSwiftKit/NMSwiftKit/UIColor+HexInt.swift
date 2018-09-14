//
//  UIColor+HexInt.swift
//  NMSwiftKit
//
//  Created by Billy Chan on 9/14/18.
//  Copyright © 2018 Billy Chan. All rights reserved.
//

import UIKit

public extension UIColor {
    public convenience init(hex: Int32, alpha: Int8 = Int8(0xFF)) {
        var mutableHex = hex
        
        let blue = CGFloat(mutableHex & 0xFF) / 255.0
        mutableHex = mutableHex >> 8
        
        let green = CGFloat(mutableHex & 0xFF) / 255.0
        mutableHex = mutableHex >> 8
        
        let red = CGFloat(mutableHex & 0xFF) / 255.0
        
        self.init(red: red, green: green, blue: blue, alpha: CGFloat(alpha) / 255.0)
    }
}
