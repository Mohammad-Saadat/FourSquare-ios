//
//  HomeEndpoint.swift
//  FourSquare-ios
//
//  Created by mohammadSaadat on 5/30/1399 AP.
//  Copyright (c) 1399 mohammad. All rights reserved.
//

import Foundation

enum HomeEndpoint {
//    case something
}

extension HomeEndpoint: RequestProtocol {
    
    public var relativePath: String {
//        switch self {
//        case .something: return "/"
//        }
        return "/"
    }
    
    public var method: HTTPMethod {
//        switch self {
//        case .something: return .get
//        }
        return .get
    }
    
    public var requestType: RequestType {
//        switch self {
//        case .something:
//            return .requestPlain
//        }
        return .requestPlain
    }
    
    public var headers: [String: String]? {
        return ["Content-Type": "application/json"]
    }
    
    var authorizationType: AuthType {
        return .bearer
    }
}
