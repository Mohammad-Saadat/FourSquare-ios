//
//  WindowManager.swift
//  FourSquare-ios
//
//  Created by mohammadSaadat on 5/30/1399 AP.
//  Copyright © 1399 mohammad. All rights reserved.
//

import Foundation
import UIKit

public class WindowManager {
    let window: UIWindow?
    
    init(window: UIWindow?) {
        self.window = window
    }
    
    func routeToForceUpdateViewController(_ message: String, title: String = "Error".localized) {
        
    }
    
    func dismissAllViewControllers(_ animated: Bool) {
        window?.rootViewController?.dismiss(animated: animated, completion: nil)
    }
}
