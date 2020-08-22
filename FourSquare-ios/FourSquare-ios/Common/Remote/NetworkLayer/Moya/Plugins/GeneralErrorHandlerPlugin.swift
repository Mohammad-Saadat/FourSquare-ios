//
//  GeneralErrorHandlerPlugin.swift
//  FourSquare-ios
//
//  Created by mohammadSaadat on 5/30/1399 AP.
//  Copyright © 1399 mohammad. All rights reserved.
//

import Foundation
import Moya
import UIKit

class GeneralErrorHandlerPlugin: PluginType {
    static let `default` = GeneralErrorHandlerPlugin()
    
    func didReceive(_ result: Result<Moya.Response, MoyaError>, target: TargetType) {
        handleIfGenericErrorHasBeenHappened(result)
    }
    
    func handleIfGenericErrorHasBeenHappened(_ result: Result<Moya.Response, MoyaError>) {
        guard case Result.failure(let error) = result else { return }
        if let generalError = GeneralErrors.parseError(error) {
            generalError.getHandler().handleError()
        }
    }

}
