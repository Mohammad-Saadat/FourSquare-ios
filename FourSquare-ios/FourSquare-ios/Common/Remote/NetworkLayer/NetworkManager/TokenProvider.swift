//
//  TokenProvider.swift
//  FourSquare-ios
//
//  Created by mohammadSaadat on 5/30/1399 AP.
//  Copyright © 1399 mohammad. All rights reserved.
//

import Foundation

protocol TokenProviderProtocol {
    func fetchToken() -> String
}
