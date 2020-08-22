//
//  GeneralErrors.swift
//  FourSquare-ios
//
//  Created by mohammadSaadat on 5/30/1399 AP.
//  Copyright © 1399 mohammad. All rights reserved.
//

import Foundation
import Moya

enum GeneralErrors: Error, LocalizedError {
    case unAuthorized(messages: String?)
    case forceUpdate(messages: String?)
    
    var errorDescription: String? {
        switch self {
        case .unAuthorized(let messages):
            return messages ?? "Unauthorized"
        case .forceUpdate(let messages):
            return messages ?? "This app version is no longer supported."
        }
    }
    
    func getHandler() -> ErrorHandlerProtocol {
        switch self {
        case .unAuthorized:
            return UnAuthorizedErrorHandler(error: self)
        case .forceUpdate:
            return ForceUpdateErrorHandler(error: self)
        }
    }
}

extension GeneralErrors {
    static func parseError(_ error: Error) -> GeneralErrors? {
        guard let moyaError = error as? MoyaError else { return nil }
        
        func parseErrorMessages(_ errorData: Data) -> String? {
            guard let response = try? JSONDecoder().getInstance().decode(BackendError.self, from: errorData) else { return nil }
            return response.errors.joined(separator: ",")
        }
        if case .underlying(_, let moyaResponse) = moyaError ,
            let response = moyaResponse {
            switch moyaResponse?.statusCode {
            case 401?:
                return GeneralErrors.unAuthorized(messages: parseErrorMessages(response.data))
            case 426?:
                return GeneralErrors.forceUpdate(messages: parseErrorMessages(response.data))
            default:
                return nil
            }
        }
        return nil
    }
}
