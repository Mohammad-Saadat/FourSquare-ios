//
//  NeworkManagerFactory.swift
//  FourSquare-ios
//
//  Created by mohammadSaadat on 5/30/1399 AP.
//  Copyright © 1399 mohammad. All rights reserved.
//

import Foundation

protocol NetworkManagerFactoryType {
    func createNetworkManager() -> NetworkManagerProtocol
}

struct NetworkManagerFactory: NetworkManagerFactoryType {
    func createNetworkManager() -> NetworkManagerProtocol {
        let networkManager = NetworkManager(tokenProvider: TokenProvider(), appInfoProvider: AppInfoProvider())
        return networkManager
    }
    
    
}

struct TokenProvider: TokenProviderProtocol {
    func fetchToken() -> String {
        return ""
    }
}


struct AppInfoProvider: AppInfoProviderProtocol {
    var clientId: String {
        return InfoDictionary.main.clientId
    }
    
    var secretId: String {
        return InfoDictionary.main.clientSecret
    }
    
    var apiKey: String {
        return ""
    }
    
    var appVersion: String {
        return InfoDictionary.main.shortVersion
    }
}
