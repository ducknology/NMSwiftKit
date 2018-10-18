//
//  SimpleAlert.swift
//  NMSwiftKit
//
//  Created by Billy Chan on 18/10/2018.
//  Copyright © 2018 Billy Chan. All rights reserved.
//

import UIKit

struct SimpleAlert {
    static let instance = SimpleAlert()
    var parentViewControllerFactory: (() throws -> UIViewController)?
    var confirmActionFactory = {() -> UIAlertAction in
        return UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: nil)
    }
    
    mutating func setDefaultParentFactory(_ factory: @escaping () -> UIViewController) {
        self.parentViewControllerFactory = factory
    }
    
    mutating func setDefaultConfirmActionFactory(_ factory: @escaping () -> UIAlertAction ) {
        self.confirmActionFactory = factory
    }
    
    func alert(title: String?, message: String?, parrentViewController: UIViewController? ) {
        do {
            let parentFromFactory = try self.parentViewControllerFactory?()
            guard let targetViewController = parrentViewController ?? parentFromFactory else {
                return
            }
            
            let controller = UIAlertController(title: title, message: message, preferredStyle: .alert)
            controller.addAction(self.confirmActionFactory())
            
            targetViewController.present(targetViewController, animated: true, completion: nil)
        } catch {}
    }
}
