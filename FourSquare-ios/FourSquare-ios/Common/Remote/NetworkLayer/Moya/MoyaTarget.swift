//
//  MoyaTarget.swift
//  FourSquare-ios
//
//  Created by mohammadSaadat on 5/30/1399 AP.
//  Copyright © 1399 mohammad. All rights reserved.
//

import Foundation
import Moya

class MoyaTarget: TargetType, AccessTokenAuthorizable {
    var authorizationType: AuthorizationType?
    var path: String
    var method: Moya.Method = .get
    var sampleData: Data
    var task: Task = .requestPlain
    var headers: [String: String]?
    var baseURL: URL
    let jsonEncoder: JSONEncoder
    
    init(mockFlashRequest: RequestProtocol, jsonEncoder: JSONEncoder) {
        self.jsonEncoder = jsonEncoder
        self.baseURL = mockFlashRequest.baseURL
        self.path = mockFlashRequest.relativePath
        self.sampleData = Data()
        self.headers = mockFlashRequest.headers
        self.setTask(type: mockFlashRequest.requestType)
        self.setMoyaMethod(method: mockFlashRequest.method)
        self.setAuthorizationType(type: mockFlashRequest.authorizationType)
    }
    
    private func setAuthorizationType(type: AuthType) {
        switch type {
        case .none:
            self.authorizationType = nil
        case .basic:
            self.authorizationType = .basic
        case .bearer:
            self.authorizationType = .bearer
        case .custom(let param):
            self.authorizationType = .custom(param)
        }
    }
    
    private func setTask(type: RequestType) {
        switch type {
        case .requestPlain:
            self.task = .requestPlain
        case .requestJSONEncodable(let encodable):
            self.task = .requestCustomJSONEncodable(encodable, encoder: self.jsonEncoder)
        case .requestParameters(let urlParameters):
            self.task = .requestParameters(parameters: urlParameters, encoding: URLEncoding.queryString)
        case .uploadCompositeMultipart(let formData, let urlParameters):
            let moyaFormData: [MultipartFormData] = formData.map { MultipartFormData.init(provider: getMoyaFileProvider($0.provider), name: $0.name, fileName: $0.fileName, mimeType: $0.mimeType)}
            if let urlParameter = urlParameters {
                self.task = .uploadCompositeMultipart(moyaFormData, urlParameters: urlParameter)
            } else {
                self.task = .uploadMultipart(moyaFormData)
            }
        }
    }
    
    private func getMoyaFileProvider(_ provider: FormData.FormDataProvider) -> MultipartFormData.FormDataProvider {
        switch provider {
            
        case .data(let param):
            return .data(param)
        case .file(let param):
            return .file(param)
        case .stream(let param1, let param2):
            return .stream(param1, param2)
        }
    }
    
    private func setMoyaMethod(method: HTTPMethod) {
        switch method {
        case .options:
            self.method = .options
        case .get:
            self.method = .get
        case .head:
            self.method = .head
        case .post:
            self.method = .post
        case .put:
            self.method = .put
        case .patch:
            self.method = .patch
        case .delete:
            self.method = .delete
        case .trace:
            self.method = .trace
        case .connect:
            self.method = .connect
        }
    }
}

