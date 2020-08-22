//
//  NetworkManager.swift
//  FourSquare-ios
//
//  Created by mohammadSaadat on 5/30/1399 AP.
//  Copyright © 1399 mohammad. All rights reserved.
//

import Foundation
import PromiseKit

class NetworkManager: NetworkManagerProtocol {
    
    let tokenProvider: TokenProviderProtocol
    let appInfoProvider: AppInfoProviderProtocol
    
    internal init(tokenProvider: TokenProviderProtocol, appInfoProvider: AppInfoProviderProtocol) {
        self.tokenProvider = tokenProvider
        self.appInfoProvider = appInfoProvider
    }
    
    lazy var moyaService = MoyaService<MoyaTarget>(jsonDecoder: JSONDecoder().getInstance(), tokenProvider: self.tokenProvider, appInfoProvider: self.appInfoProvider)
    lazy var jsonEncoder = JSONEncoder().getInstance()
    
    func request<Request, Response>(_ request: Request) -> Promise<Response> where Request: RequestProtocol, Response: Decodable {
        let moyaTarget = MoyaTarget.init(mockFlashRequest: request, jsonEncoder: jsonEncoder)
        let response: Promise<Response> = self.moyaService.provider.request(moyaTarget)
        return response
    }
    
    func request<Request>(_ request: Request) -> Promise<Void> where Request: RequestProtocol {
        let moyaTarget = MoyaTarget.init(mockFlashRequest: request, jsonEncoder: jsonEncoder)
        let response: Promise<Void> = self.moyaService.provider.request(moyaTarget)
        return response
    }
}
