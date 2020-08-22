//
//  AppInfoPlugin.swift
//  FourSquare-ios
//
//  Created by mohammadSaadat on 5/30/1399 AP.
//  Copyright © 1399 mohammad. All rights reserved.
//

import Moya

struct AppInfoPlugin: PluginType {
    let appInfoProvider: AppInfoProviderProtocol
    
    func prepare(_ request: URLRequest, target: TargetType) -> URLRequest {
        // Create temp request
        var request = request
        request.addValue(appInfoProvider.apiKey, forHTTPHeaderField: "x-api-key")
        return request
    }
    
    func didReceive(_ result: Result<Response, MoyaError>, target: TargetType) {
        debugPrint("didReceive(_ result: Result<Response, MoyaError>, target: TargetType)")
    }
}

