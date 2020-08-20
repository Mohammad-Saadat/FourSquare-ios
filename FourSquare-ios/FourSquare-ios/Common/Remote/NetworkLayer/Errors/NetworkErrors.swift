//
//  NetworkErrors.swift
//  FourSquare-ios
//
//  Created by mohammadSaadat on 5/30/1399 AP.
//  Copyright © 1399 mohammad. All rights reserved.
//

import Foundation
import Moya
import PromiseKit

enum NetworkErrors: Error, LocalizedError {
    case connectionTimeout
    case forbidden(messages: String?)
    case noNetworkConnectivity
    case notFound(messages: String?)
    case other(messages: String?)
    case tooManyRequest
    
    var errorDescription: String? {
        switch self {
        case .connectionTimeout:
            return "No Network Access"
        case .forbidden(let messages):
            return messages ?? "Forbidden"
        case .noNetworkConnectivity:
            return "Turn on cellular data or use Wi-Fi to access the refresh data"
        case .notFound(let messages):
            return messages ?? "Not Found"
        case .other(let messages):
            return messages ?? "Unknown Error"
        case .tooManyRequest:
            return "Too many requests"
        }
    }
    
    var isRetryable: Bool {
        switch self {
        case .connectionTimeout:
            return true
        case .forbidden:
            return false
        case .noNetworkConnectivity:
            return true
        case .notFound:
            return false
        case .other:
            return true
        case .tooManyRequest:
            return false
        }
    }
}

// ======================
// MARK: - Error Handling
// ======================
extension NetworkErrors {
    static func parseError<T>(_ error: Error) -> Promise<T> { // swiftlint:disable:this cyclomatic_complexity
//        Bugfender.error(error, tag: "network")
        
        guard let moyaError = error as? MoyaError else { return Promise(error: error) }
        var result: Promise<T> = Promise(error: error)
        
        func parseErrorMessages(_ errorData: Data) -> String? {
            guard let response = try? JSONDecoder().getInstance().decode(BackendError.self, from: errorData) else { return nil }
            return response.errors.joined(separator: ",")
        }
        
        switch moyaError {
        case .objectMapping:
            debugPrint("ObjectMapping error = \(type(of: result)) -> \(result)")
        case .underlying(let error, let moyaResponse):
            guard let response = moyaResponse else {
                // Reference: https://developer.apple.com/documentation/foundation/1508628-url_loading_system_error_codes
                // Check network connectivity
                let nSURLErrorNotConnectedToInternet = 13
                let castErrorToNsError = error as NSError
                if castErrorToNsError.code == nSURLErrorNotConnectedToInternet {
                    result = Promise(error: NetworkErrors.noNetworkConnectivity)
                }
                return result
            }
            switch response.statusCode {
            case 400:
                result = Promise(error: NetworkErrors.other(messages: parseErrorMessages(response.data)))
            case 403:
                result = Promise(error: NetworkErrors.forbidden(messages: parseErrorMessages(response.data)))
            case 404:
                result = Promise(error: NetworkErrors.notFound(messages: parseErrorMessages(response.data)))
            case 429:
                result = Promise(error: NetworkErrors.tooManyRequest)
            case 500:
                result = Promise(error: NetworkErrors.notFound(messages: parseErrorMessages(response.data)))
            case (400..<500):
                result = Promise(error: NetworkErrors.other(messages: parseErrorMessages(response.data)))
            case 504:
                result = Promise(error: NetworkErrors.connectionTimeout)
            default:
                break
            }
        default:
            break
        }
        return result
    }
}
