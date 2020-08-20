//
//  CALayerExtension.swift
//  FourSquare-ios
//
//  Created by mohammadSaadat on 5/30/1399 AP.
//  Copyright © 1399 mohammad. All rights reserved.
//

import Foundation
import UIKit

extension CALayer {
    func addCornerRadius(_ value: CGFloat) {
        self.masksToBounds = true
        self.cornerRadius = value
    }

    func addBorder(_ width: CGFloat, color: UIColor) {
        self.borderWidth = width
        self.borderColor = color.cgColor
    }
    
    func removeBorder() {
        self.borderWidth = 0.0
    }   
}
