//
//  SimpleAlert.swift
//  NMSwiftKit
//
//  Created by Billy Chan on 18/10/2018.
//  Copyright © 2018 Billy Chan. All rights reserved.
//

import UIKit

public class SimpleAlert {
    public enum AlertError: Error {
        case noParentViewController
    }
    
    public static let instance = SimpleAlert()
    public var parentViewControllerFactory: (() throws -> UIViewController)?
    public var confirmActionFactory = {() -> UIAlertAction in
        return UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: nil)
    }
    
    public func alert(title: String?, message: String, parrentViewController: UIViewController? = nil) {
        let parentFromFactory: UIViewController?
        
        do {
            parentFromFactory = try self.parentViewControllerFactory?()
        } catch {
            return
        }
        
        guard let targetViewController = parrentViewController ?? parentFromFactory else {
            return
        }
        
        let controller = UIAlertController(title: title, message: message, preferredStyle: .alert)
        controller.addAction(self.confirmActionFactory())
        
        targetViewController.present(controller, animated: true, completion: nil)
    }
    
    public func confirmAlert(_ title: String?, message: String, ok: String, cancel: String, action: @escaping (_: Bool) -> Void, parentViewController: UIViewController? = nil) {
        let parentFromFactory: UIViewController?
        
        do {
            parentFromFactory = try self.parentViewControllerFactory?()
        } catch {
            return
        }
        
        guard let targetViewController = parentViewController ?? parentFromFactory else {
            return
        }
        
        let controller = UIAlertController(title: title, message: message, preferredStyle: .alert)
        
        controller.addAction(
            UIAlertAction(title: ok, style: .default, handler: { _ in
                action(true)
            })
        )
        
        controller.addAction(
            UIAlertAction(title: cancel, style: .cancel, handler: { _ in
                action(false)
            })
        )
        
        targetViewController.present(controller, animated: true, completion: nil)
    }
}
