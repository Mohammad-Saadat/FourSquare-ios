//
//  Logger.swift
//  FourSquare-ios
//
//  Created by mohammadSaadat on 5/30/1399 AP.
//  Copyright © 1399 mohammad. All rights reserved.
//

import Foundation

class Logger {
    class var prefix: String {
        return "Unknown Prefixs"
    }
    private static let separator = " -> "
    
    class func logInit(owner: String) {
        let string = "LifeCycle" + separator + owner + " init"
        print(string)
    }
    
    class func logDeinit(prefix: String? = nil, owner: String) {
        let string = "LifeCycle" + separator + owner + " deinit"
        print(string)
    }
    
    class func log(prefix: String? = nil, text: String) {
        print(text)
    }
    
    private class func appendPrefix(string: inout String) {
        string = prefix + separator + string
    }
    
    private class func print(_ string: String) {
        var string = string
        appendPrefix(string: &string)
        debugPrint(string)
    }
}

