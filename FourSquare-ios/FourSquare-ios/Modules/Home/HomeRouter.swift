//
//  HomeRouter.swift
//  FourSquare-ios
//
//  Created by mohammadSaadat on 5/30/1399 AP.
//  Copyright (c) 1399 mohammad. All rights reserved.
//

import UIKit

@objc protocol HomeRoutingLogic {
    //    func navigateToSomewhere()
}

protocol HomeDataPassing {
    var dataStore: HomeDataStore? { get }
}

class HomeRouter: NSObject, HomeDataPassing {
    // MARK: - Object lifecycle
    override init() {
        HomeLogger.logInit(owner: String(describing: HomeRouter.self))
    }
    
    // MARK: - Deinit
    deinit {
        HomeLogger.logDeinit(owner: String(describing: HomeRouter.self))
    }
    
    // MARK: - Properties
    
    // MARK: Public
    weak var viewController: HomeViewController?
    var dataStore: HomeDataStore?
}

// MARK: - Methods

// MARK: Private
private extension HomeRouter {}

// MARK: Public
extension HomeRouter {}

// MARK: - Routin Logic
extension HomeRouter: HomeRoutingLogic {
    // MARK: Navigation
}
