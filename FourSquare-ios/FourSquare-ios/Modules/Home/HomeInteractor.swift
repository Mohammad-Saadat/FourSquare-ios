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
    init() {
        HomeLogger.logInit(owner: String(describing: HomeInteractor.self))
    }
    
    // MARK: - Deinit
    deinit {
        HomeLogger.logDeinit(owner: String(describing: HomeInteractor.self))
    }
    
    // MARK: - Properties
    
    // MARK: Public
    var presenter: HomePresentationLogic?
    var worker: HomeWorkerLogic?
}

// MARK: - Methods

// MARK: Private
private extension HomeInteractor {}

// MARK: Public
extension HomeInteractor {}

// MARK: - Business Logics
extension HomeInteractor: HomeBusinessLogic {}
