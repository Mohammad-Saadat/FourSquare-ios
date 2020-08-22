//
//  NetworkLoggerPlugin.swift
//  FourSquare-ios
//
//  Created by mohammadSaadat on 5/30/1399 AP.
//  Copyright © 1399 mohammad. All rights reserved.
//

import Moya

extension NetworkLoggerPlugin {
    static let `default`: NetworkLoggerPlugin = .init(configuration: .init(logOptions: [.requestBody, .formatRequestAscURL]))
}
