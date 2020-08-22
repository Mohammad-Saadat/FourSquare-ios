//
//  HomeDependencyContainer.swift
//  FourSquare-ios
//
//  Created by mohammadSaadat on 5/30/1399 AP.
//  Copyright (c) 1399 mohammad. All rights reserved.
//

import Foundation

class HomeDependencyContainer: DependencyContainer {
    // MARK: - Object lifecycle
    override init() {
        HomeLogger.logInit(owner: String(describing: HomeDependencyContainer.self))
    }
    
    // MARK: - Deinit
    deinit {
        HomeLogger.logDeinit(owner: String(describing: HomeDependencyContainer.self))
    }
}

// MARK: - Factory
extension HomeDependencyContainer: HomeFactory {
    func makeTestModuleLocationManager() -> LocationManager {
        return LocationManager()
    }
    
    func makeTestModuleReachability() -> Reachability {
        return Reachability()
    }
    
    func makeTestModuleCoreDataService() -> CoreDataService {
        return CoreDataService(context: self.persistentContainer)
    }
    
    func makeHomeViewController() -> HomeViewController {
        return HomeViewController(factory: self)
    }
    
    func makeHomeService() -> HomeService {
        return HomeService(networkManager: networkManager)
    }
}
