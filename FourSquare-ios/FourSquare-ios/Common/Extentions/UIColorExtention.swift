//
//  UIColorExtention.swift
//  FourSquare-ios
//
//  Created by mohammadSaadat on 5/30/1399 AP.
//  Copyright © 1399 mohammad. All rights reserved.
//

import UIKit

extension UIColor {
    convenience init(hexString: String) {
        let red, green, blue, alpha: CGFloat
        if hexString.hasPrefix("#") {
            let index = hexString.index(hexString.startIndex, offsetBy: 1)
            let beginning = hexString[index...]
            var hexColor = String(beginning)
            if hexColor.count == 6 {
                hexColor = "ff\(hexColor)"
            }
            let scanner = Scanner(string: hexColor)
            var hexNumber: UInt64 = 0
            if scanner.scanHexInt64(&hexNumber) {
                let newAlpha = CGFloat((hexNumber & 0xff000000) >> 24)
                alpha = newAlpha / 255
                let newRed = CGFloat((hexNumber & 0x00ff0000) >> 16)
                red = newRed / 255
                let newGreen = CGFloat((hexNumber & 0x0000ff00) >> 8)
                green = newGreen / 255
                let newBlue = CGFloat(hexNumber & 0x000000ff)
                blue = newBlue / 255
                self.init(red: red, green: green, blue: blue, alpha: alpha)
                return
            }
        }
        self.init(white: 1.0, alpha: 0.0)
    }
    
    convenience init(hexString: String, alpha: CGFloat? = nil) {
        let alpha: CGFloat = alpha ?? 1.0
        let red, green, blue: CGFloat
        if hexString.hasPrefix("#") {
            let index = hexString.index(hexString.startIndex, offsetBy: 1)
            let beginning = hexString[index...]
            var hexColor = String(beginning)
            if hexColor.count == 6 {
                hexColor = "ff\(hexColor)"
            }
            let scanner = Scanner(string: hexColor)
            var hexNumber: UInt64 = 0
            if scanner.scanHexInt64(&hexNumber) {
                let newRed = CGFloat((hexNumber & 0x00ff0000) >> 16)
                red = newRed / 255
                let newGreen = CGFloat((hexNumber & 0x0000ff00) >> 8)
                green = newGreen / 255
                let newBlue = CGFloat(hexNumber & 0x000000ff)
                blue = newBlue / 255
                self.init(red: red, green: green, blue: blue, alpha: alpha)
                return
            }
        }
        self.init(white: 1.0, alpha: 0.0)
    }
}
