//
//  RequestProtocol.swift
//  FourSquare-ios
//
//  Created by mohammadSaadat on 5/30/1399 AP.
//  Copyright © 1399 mohammad. All rights reserved.
//
import Foundation

public enum HTTPMethod: String {
    case options = "OPTIONS"
    case get     = "GET"
    case head    = "HEAD"
    case post    = "POST"
    case put     = "PUT"
    case patch   = "PATCH"
    case delete  = "DELETE"
    case trace   = "TRACE"
    case connect = "CONNECT"
}

public enum AuthType {
    case none
    case basic
    case bearer
    case custom(String)

    public var value: String? {
        switch self {
        case .none: return nil
        case .basic: return "Basic"
        case .bearer: return "Bearer"
        case .custom(let customValue): return customValue
        }
    }
}

public struct FormData {

    public enum FormDataProvider {
        case data(Foundation.Data)
        case file(URL)
        case stream(InputStream, UInt64)
    }

    public init(provider: FormDataProvider, name: String, fileName: String? = nil, mimeType: String? = nil) {
        self.provider = provider
        self.name = name
        self.fileName = fileName
        self.mimeType = mimeType
    }

    public let provider: FormDataProvider
    public let name: String
    public let fileName: String?
    public let mimeType: String?

}

public enum RequestType {
    case requestPlain
    case requestJSONEncodable(Encodable)
    case requestParameters(urlParameters: [String: Any])
    case uploadCompositeMultipart([FormData], urlParameters: [String: Any]?)
}

protocol RequestProtocol {
    var baseURL: URL {get}
    var relativePath: String {get}
    var method: HTTPMethod {get}
    var headers: [String: String]? {get}
    var authorizationType: AuthType {get}
    var requestType: RequestType {get}
}

extension RequestProtocol {
    var baseURL: URL {
        guard let url = URL(string: InfoDictionary.main.baseURL) else {
            assertionFailure("Base URL Not Found!")
            return URL.init(string: "www.google.com")! // swiftlint:disable:this force_unwrapping
        }
        return url
    }
    
    var authorizationType: AuthType {
        return .bearer
    }
}
