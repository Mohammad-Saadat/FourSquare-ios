//
//  HomeEndpoint.swift
//  FourSquare-ios
//
//  Created by mohammadSaadat on 5/30/1399 AP.
//  Copyright (c) 1399 mohammad. All rights reserved.
//

import Foundation

enum HomeEndpoint {
    case getVenues(params: VenueParams)
}

extension HomeEndpoint: RequestProtocol {
    
    public var relativePath: String {
        switch self {
        case .getVenues: return "/venues/explore"
        }
    }
    
    public var method: HTTPMethod {
        switch self {
        case .getVenues: return .get
        }
    }
    
    public var requestType: RequestType {
        switch self {
        case .getVenues(let params):
            let parameters: [String: Any] = ["client_id": params.clientId,
                                             "client_secret": params.clientSecret,
                                             "v": params.v,
                                             "ll": params.ll,
                                             "limit": params.limit,
                                             "offset": params.offset]
            return .requestParameters(urlParameters: parameters)
        }
    }
    
    public var headers: [String: String]? {
        return ["Content-Type": "application/json"]
    }
    
    var authorizationType: AuthType {
        return .bearer
    }
}
