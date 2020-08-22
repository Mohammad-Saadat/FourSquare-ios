//
//  File.swift
//  FourSquare-ios
//
//  Created by mohammadSaadat on 5/30/1399 AP.
//  Copyright © 1399 mohammad. All rights reserved.
//

import Foundation

public extension JSONEncoder {
    /// Default JSONEncoder
    func getInstance() -> JSONEncoder {
        dateEncodingStrategy = .iso8601
        keyEncodingStrategy = .convertToSnakeCase
        return self
    }
}
