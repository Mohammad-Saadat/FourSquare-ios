//
//  DetailDependencyContainer.swift
//  TRB
//
//  Created by mohammad on 8/18/20.
//  Copyright (c) 2020 RoundTableApps. All rights reserved.
//

import Foundation

class DetailDependencyContainer: DependencyContainer {
    // MARK: - Object lifecycle
    override init() {
        DetailLogger.logInit(owner: String(describing: DetailDependencyContainer.self))
    }
    
    // MARK: - Deinit
    deinit {
        DetailLogger.logDeinit(owner: String(describing: DetailDependencyContainer.self))
    }
}

// MARK: - Factory
extension DetailDependencyContainer: DetailFactory {
    func makeDetailViewController(venue: Venue) -> DetailViewController {
        let detailViewController =  DetailViewController(factory: self)
        detailViewController.router?.dataStore?.venue = venue
        return detailViewController
    }
    
    func makeDetailService() -> DetailService {
        return DetailService(networkManager: networkManager)
    }
}
