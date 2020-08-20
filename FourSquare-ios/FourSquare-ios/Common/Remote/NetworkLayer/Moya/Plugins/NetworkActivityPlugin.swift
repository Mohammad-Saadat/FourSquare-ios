//
//  NetworkActivityPlugin.swift
//  FourSquare-ios
//
//  Created by mohammadSaadat on 5/30/1399 AP.
//  Copyright © 1399 mohammad. All rights reserved.
//

import Moya

extension NetworkActivityPlugin {
    static let `default`: NetworkActivityPlugin = .init { (networkActivityChangeType, _) in
        DispatchQueue.main.async {
            switch networkActivityChangeType {
            case .began:
                UIApplication.shared.isNetworkActivityIndicatorVisible = true
            case .ended:
                UIApplication.shared.isNetworkActivityIndicatorVisible = false
            }
        }
    }
}
