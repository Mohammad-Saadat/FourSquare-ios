//
//  DetailRouter.swift
//  TRB
//
//  Created by mohammad on 8/18/20.
//  Copyright (c) 2020 RoundTableApps. All rights reserved.
//

import UIKit

@objc protocol DetailRoutingLogic {
    //    func navigateToSomewhere()
}

protocol DetailDataPassing {
    var dataStore: DetailDataStore? { get set }
}

class DetailRouter: NSObject, DetailDataPassing {
    // MARK: - Object lifecycle
    override init() {
        DetailLogger.logInit(owner: String(describing: DetailRouter.self))
    }
    
    // MARK: - Deinit
    deinit {
        DetailLogger.logDeinit(owner: String(describing: DetailRouter.self))
    }
    
    // MARK: - Properties
    
    // MARK: Public
    weak var viewController: DetailViewController?
    var dataStore: DetailDataStore?
}

// MARK: - Methods

// MARK: Private
private extension DetailRouter {}

// MARK: Public
extension DetailRouter {}

// MARK: - Routin Logic
extension DetailRouter: DetailRoutingLogic {
    // MARK: Navigation
}
