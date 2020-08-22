//
//  NetworkManagerProtocol.swift
//  FourSquare-ios
//
//  Created by mohammadSaadat on 5/30/1399 AP.
//  Copyright © 1399 mohammad. All rights reserved.
//

import Foundation
import PromiseKit

protocol NetworkManagerProtocol {
    func request<Request: RequestProtocol, Response: Decodable>(_ request: Request) -> Promise<Response>
    func request<Request: RequestProtocol>(_ request: Request) -> Promise<Void>
}
