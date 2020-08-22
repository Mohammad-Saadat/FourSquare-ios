//
//  MoyaService.swift
//  FourSquare-ios
//
//  Created by mohammadSaadat on 5/30/1399 AP.
//  Copyright © 1399 mohammad. All rights reserved.
//

import Moya

class MoyaService<TargetType: Moya.TargetType> {
    // ==================
    // MARK: - Properties
    // ==================
    let jsonDecoder: JSONDecoder
    let tokenProvider: TokenProviderProtocol
    let appInfoProvider: AppInfoProviderProtocol
    let tokenPlugin: AccessTokenPlugin
    
    init(jsonDecoder: JSONDecoder, tokenProvider: TokenProviderProtocol, appInfoProvider: AppInfoProviderProtocol) {
        self.jsonDecoder = jsonDecoder
        self.tokenProvider = tokenProvider
        self.appInfoProvider = appInfoProvider
        self.tokenPlugin = AccessTokenPlugin(tokenClosure: { [tokenProvider] (type) -> String in
            return tokenProvider.fetchToken()
        })
    }
    /// Moya Provider
    lazy var provider = CustomMoyaProvider<TargetType>(jsonDecoder: jsonDecoder, plugins: [
        NetworkLoggerPlugin.default,
        NetworkActivityPlugin.default,
        AppInfoPlugin(appInfoProvider: self.appInfoProvider),
        self.tokenPlugin,
        GeneralErrorHandlerPlugin.default
        ])
    
    lazy var stubProvider = CustomMoyaProvider<TargetType>(jsonDecoder: jsonDecoder, stubClosure: { _ -> StubBehavior in
        return .delayed(seconds: 2.0)
    }, plugins: [
        NetworkLoggerPlugin.default,
        NetworkActivityPlugin.default,
        AppInfoPlugin(appInfoProvider: self.appInfoProvider),
        self.tokenPlugin,
        GeneralErrorHandlerPlugin.default
    ])
}

