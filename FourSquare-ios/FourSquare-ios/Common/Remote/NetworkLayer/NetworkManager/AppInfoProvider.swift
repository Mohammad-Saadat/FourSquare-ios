//
//  AppInfoProvider.swift
//  FourSquare-ios
//
//  Created by mohammadSaadat on 5/30/1399 AP.
//  Copyright © 1399 mohammad. All rights reserved.
//

import Foundation

protocol AppInfoProviderProtocol {
    var apiKey: String {get}
    var appVersion: String {get}
    var clientId: String {get}
    var secretId: String {get}
}
