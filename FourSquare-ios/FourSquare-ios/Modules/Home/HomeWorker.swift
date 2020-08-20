//
//  HomeWorker.swift
//  FourSquare-ios
//
//  Created by mohammadSaadat on 5/30/1399 AP.
//  Copyright (c) 1399 mohammad. All rights reserved.
//

import UIKit

protocol HomeWorkerLogic {}

class HomeWorker {
    // MARK: - Object lifecycle
    init(service: HomeService) {
        HomeLogger.logInit(owner: String(describing: HomeWorker.self))
        self.service = service
    }
    
    // MARK: - Deinit
    deinit {
        HomeLogger.logDeinit(owner: String(describing: HomeWorker.self))
    }
    
    // MARK: - Properties
    
    // MARK: Private
    private let service: HomeService
}

// MARK: - Methods

// MARK: Private
private extension HomeWorker {}

// MARK: - Worker Logic
extension HomeWorker: HomeWorkerLogic {}
