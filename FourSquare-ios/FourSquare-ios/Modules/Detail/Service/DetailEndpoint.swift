//
//  DetailEndpoint.swift
//  TRB
//
//  Created by mohammad on 8/18/20.
//  Copyright (c) 2020 RoundTableApps. All rights reserved.
//

import Foundation

enum DetailEndpoint {
    case getDetailVenue(params: DetailVenueParams)
}

extension DetailEndpoint: RequestProtocol {
    
    public var relativePath: String {
        switch self {
        case .getDetailVenue(let params): return "/venues/\(params.id)"
        }
    }
    
    public var method: HTTPMethod {
        switch self {
        case .getDetailVenue: return .get
        }
    }
    
    public var requestType: RequestType {
        switch self {
        case .getDetailVenue(params: let params):
            let parameters: [String: Any] = ["client_id": params.clientId,
                                             "client_secret": params.clientSecret,
                                             "v": params.v]
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
