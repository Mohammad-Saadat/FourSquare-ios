//
//  HomeService.swift
//  FourSquare-ios
//
//  Created by mohammadSaadat on 5/30/1399 AP.
//  Copyright (c) 1399 mohammad. All rights reserved.
//

import Foundation
import PromiseKit

final class HomeService {
    // MARK: - Object lifecycle
    init(networkManager: NetworkManagerProtocol) {
        self.networkManager = networkManager
        HomeLogger.logInit(owner: String(describing: HomeService.self))
    }
    
    // MARK: - Deinit
    deinit {
        HomeLogger.logDeinit(owner: String(describing: HomeService.self))
    }
    
    // MARK: - Properties
    
    // MARK: Private
    private let networkManager: NetworkManagerProtocol
}

// MARK: - Methods

// MARK: Public
extension HomeService {}
