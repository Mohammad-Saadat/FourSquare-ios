//
//  JSONDecoderExtension.swift
//  FourSquare-ios
//
//  Created by mohammadSaadat on 5/30/1399 AP.
//  Copyright © 1399 mohammad. All rights reserved.
//

import Foundation

public extension JSONDecoder {
    /// Default JSONDecoder
    func getInstance() -> JSONDecoder {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSZZZZZ"
        formatter.calendar = Calendar(identifier: .iso8601)
        dateDecodingStrategy = .formatted(formatter)
        keyDecodingStrategy = .convertFromSnakeCase
        return self
    }
}
