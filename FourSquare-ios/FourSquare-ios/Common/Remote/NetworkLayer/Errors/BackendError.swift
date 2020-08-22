//
//  BackendError.swift
//  FourSquare-ios
//
//  Created by mohammadSaadat on 5/30/1399 AP.
//  Copyright © 1399 mohammad. All rights reserved.
//

import Foundation

struct BackendError: Decodable {
    let errors: [String]
}
