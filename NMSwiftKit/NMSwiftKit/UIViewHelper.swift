//
//  UIViewHelper.swift
//  NMSwiftKit
//
//  Created by Billy Chan on 19/10/2018.
//  Copyright © 2018 Billy Chan. All rights reserved.
//

import UIKit

public extension UIView {
    @discardableResult public func addSubviewAndExpand(_ subview: UIView) -> SideConstrains? {
        self.addSubview(subview)
        
        return subview.expandToMatchSuperview()
    }
    
    @discardableResult public func expandToMatchSuperview() -> SideConstrains? {
        guard let superview = self.superview else {
            return nil
        }
        
        let constraints = SideConstrains(top: self.leftAnchor.constraint(equalTo: superview.leftAnchor),
                                         left: self.topAnchor.constraint(equalTo: superview.topAnchor),
                                         right: self.rightAnchor.constraint(equalTo: superview.rightAnchor),
                                         bottom: self.bottomAnchor.constraint(equalTo: superview.bottomAnchor))
        
        constraints.all.forEach { $0.isActive = true }
        
        return constraints
    }
    
    @discardableResult public func attachViewAtBottom(_ subview: UIView,
                                                      _ height: CGFloat,
                                                      constraintPiorities: UILayoutPriority = .required) -> BottomAttachConstraints? {
        //  Make sure they are under the same parent
        guard let superview = self.superview else {
            return nil
        }
        
        subview.translatesAutoresizingMaskIntoConstraints = false
        
        superview.addSubview(subview)
        
        let constraints = BottomAttachConstraints(top: subview.topAnchor.constraint(equalTo: self.bottomAnchor),
                                                  left: subview.leftAnchor.constraint(equalTo: superview.leftAnchor),
                                                  right: subview.rightAnchor.constraint(equalTo: superview.rightAnchor),
                                                  height: subview.heightAnchor.constraint(equalToConstant: height))
        
        constraints.all.forEach { constraint in
            constraint.priority = constraintPiorities
            constraint.isActive = true
        }
        
        return constraints
    }
}

public struct BottomAttachConstraints {
    let top: NSLayoutConstraint
    let left: NSLayoutConstraint
    let right: NSLayoutConstraint
    let height: NSLayoutConstraint
    
    var all: [NSLayoutConstraint] {
        return [self.top, self.left, self.right, self.height]
    }
}

public struct SideConstrains {
    let top: NSLayoutConstraint
    let left: NSLayoutConstraint
    let right: NSLayoutConstraint
    let bottom: NSLayoutConstraint
    
    var all: [NSLayoutConstraint] {
        return [self.top, self.left, self.right, self.bottom]
    }
}
