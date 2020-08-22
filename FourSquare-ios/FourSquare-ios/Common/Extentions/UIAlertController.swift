//
//  UIAlertController.swift
//  FourSquare-ios
//
//  Created by mohammadSaadat on 5/30/1399 AP.
//  Copyright © 1399 mohammad. All rights reserved.
//

import Foundation
import UIKit

extension UIAlertController {
    private static var style: UIStatusBarStyle = .default
    
    func setStyle(style: UIStatusBarStyle) {
        UIAlertController.style = style
        self.setNeedsStatusBarAppearanceUpdate()
    }
    
    override open var preferredStatusBarStyle: UIStatusBarStyle {
        return UIAlertController.style
    }
}
