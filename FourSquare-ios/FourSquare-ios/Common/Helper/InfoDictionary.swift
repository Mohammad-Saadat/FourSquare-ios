//
//  InfoDictionary.swift
//  FourSquare-ios
//
//  Created by mohammadSaadat on 5/30/1399 AP.
//  Copyright © 1399 mohammad. All rights reserved.
//

import Foundation

final class InfoDictionary {
    // =============
    // MARK: - Enums
    // =============
    enum Key: String {
        case shortVersion = "CFBundleShortVersionString"
        case buildVersion = "CFBundleVersion"
        case displayName = "CFBundleDisplayName"
        case baseURL = "Base URL"
        case clientId = "Client ID"
        case clientSecret = "Client Secret"
    }
    
    // ==================
    // MARK: - Properties
    // ==================
    
    // MARK: Instance
    private let dictionary: [String: Any]!
    
    // MARK: Static
    static private(set) var main = InfoDictionary(Bundle.main.infoDictionary)
    
    init(_ dictionary: [String: Any]!) {
        self.dictionary = dictionary
    }
    
    // ==============
    // MARK: - Fields
    // ==============
    
    // MARK: Bundle version
    private(set) lazy var shortVersion: String = self.dictionary?[Key.shortVersion.rawValue] as? String ?? ""
    
    // MARK: Build version
    private(set) lazy var buildVersion: String = self.dictionary?[Key.buildVersion.rawValue] as? String ?? ""
    
    // MARK: App Name
    private(set) lazy var displayName: String = self.dictionary?[Key.displayName.rawValue] as? String ?? ""
    // MARK: Base URL
    private(set) lazy var baseURL: String = self.dictionary?[Key.baseURL.rawValue] as? String ?? ""
    
    private(set) lazy var clientId: String = self.dictionary?[Key.clientId.rawValue] as? String ?? ""
    
    private(set) lazy var clientSecret: String = self.dictionary?[Key.clientSecret.rawValue] as? String ?? ""
}

