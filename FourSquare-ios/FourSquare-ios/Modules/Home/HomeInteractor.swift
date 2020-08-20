//
//  HomeInteractor.swift
//  FourSquare-ios
//
//  Created by mohammadSaadat on 5/30/1399 AP.
//  Copyright (c) 1399 mohammad. All rights reserved.
//

import UIKit

protocol HomeBusinessLogic {
    func startHandleLocation(request: Home.Location.Request)
    func settingButtonTappedOnLocationAlert(request: Home.LocationAlert.Request)
    func fetchNextPage(request: Home.pagination.Request)
    func getPlaceFromDB(request: Home.List.Request)
    func refreshPage(request: Home.List.Request)
}

protocol HomeDataStore {}

class HomeInteractor: HomeDataStore {
    // MARK: - Object lifecycle
    init(locationManager: LocationManager,
    worker: TestModuleWorkerLogic,
    reachability: Reachability) {
        HomeLogger.logInit(owner: String(describing: HomeInteractor.self))
        self.worker = worker
        self.locationManager = locationManager
        self.reachability = reachability
        self.setDelegates()
    }
    
    // MARK: - Deinit
    deinit {
        HomeLogger.logDeinit(owner: String(describing: HomeInteractor.self))
    }
    
    // MARK: - Properties
    
    // MARK: Public
    var presenter: HomePresentationLogic?
    var worker: HomeWorkerLogic?
    
    // MARK: Private
    private let locationManager: LocationManager
    private let reachability: Reachability
}

// MARK: - Methods

// MARK: Private
private extension HomeInteractor {
    func setDelegates() {
//        self.worker.setDelegate(with: self)
        self.locationManager.setDelegate(with: self)
        self.reachability.setDelegate(with: self)
    }
}

// MARK: Public
extension HomeInteractor {}

// MARK: - Business Logics
extension HomeInteractor: HomeBusinessLogic {}
