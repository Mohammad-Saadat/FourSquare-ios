//
//  HomeInteractor.swift
//  FourSquare-ios
//
//  Created by mohammadSaadat on 5/30/1399 AP.
//  Copyright (c) 1399 mohammad. All rights reserved.
//

import UIKit
import CoreLocation

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
    worker: HomeWorkerLogic,
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
    var worker: HomeWorkerLogic
    
    // MARK: Private
    private let locationManager: LocationManager
    private let reachability: Reachability
    
    // constraint for change location
    private let constraintDistance: Double = 100
}

// MARK: - Methods

// MARK: Private
private extension HomeInteractor {
    func setDelegates() {
        self.worker.setDelegate(with: self)
        self.locationManager.setDelegate(with: self)
        self.reachability.setDelegate(with: self)
    }
    
    func fetchPlacesWithParams(latitude: String, longitude: String) {
        let params = VenueParams(latitude: latitude, longitude: longitude)
        self.worker.fetchPlaces(params: params)
    }
    
    func checkDistanceForBeyondConstraint(latitude: String, longitude: String, params: VenueParams) {
        let newCoordinate = CLLocation(latitude: latitude.double, longitude: longitude.double)
        let oldCoordinate = CLLocation(latitude: params.latitude.double, longitude: params.longitude.double)
        let distanceInMeters = newCoordinate.distance(from: oldCoordinate)
        
        HomeLogger.log(text: "distanceInMeters = \(distanceInMeters)")
        if distanceInMeters >= constraintDistance {
            self.fetchPlacesWithParams(latitude: latitude, longitude: longitude)
        }
    }
    
    func checkPlaceParamsInDisk(latitude: String, longitude: String) {
        if let params = UserDefaults.standard.venueParams {
            self.checkDistanceForBeyondConstraint(latitude: latitude,
                                               longitude: longitude,
                                               params: params)
        } else {
            self.fetchPlacesWithParams(latitude: latitude, longitude: longitude)
        }
    }
}

// MARK: Public
extension HomeInteractor {}

// MARK: - Business Logics
extension HomeInteractor: HomeBusinessLogic {
    func refreshPage(request: Home.List.Request) {
        self.locationManager.handleLocationManagerState()
        let currentLocation = locationManager.getCurrentLocation()
        guard let lat = currentLocation.lat,
            let lng = currentLocation.lng else { return }
        fetchPlacesWithParams(latitude: lat, longitude: lng)
    }
    
    func getPlaceFromDB(request: Home.List.Request) {
        self.worker.fetchPlacesFromDB()
    }
    
    func fetchNextPage(request: Home.pagination.Request) {
        let currentLocation = locationManager.getCurrentLocation()
        guard let lat = currentLocation.lat,
            let lng = currentLocation.lng else { return }
        let nextPage = request.currentPage + 1
        let newParams = VenueParams(latitude: lat, longitude: lng, page: nextPage)
        self.worker.fetchForPagination(params: newParams)
    }
    
    func settingButtonTappedOnLocationAlert(request: Home.LocationAlert.Request) {
        guard let settingsUrl = URL(string: UIApplication.openSettingsURLString) else {
            return
        }
        if UIApplication.shared.canOpenURL(settingsUrl) {
            UIApplication.shared.open(settingsUrl) { (_) in }
        }
    }
    
    func startHandleLocation(request: Home.Location.Request) {
        locationManager.startHandleLocation()
    }
}

// MARK: - HomeWorker Delegate
extension HomeInteractor: HomeWorkerDelegate {
    func stopFooterIndicator() {
        self.presenter?.hideFooterLoading(response: Home.pagination.Response())
    }
    
    func startFooterIndicator() {
        self.presenter?.presentFooterLoading(response: Home.pagination.Response())
    }
    
    func handeleError(error: Error) {
        self.presenter?.presentError(response: Home.ModuleError.Response(error: error))
    }
    
    func startRemoteIndicator() {
        self.presenter?.presentLoading(response: Home.Loading.Response())
    }
    
    func stopRemoteIndicator() {
        self.presenter?.hideLoading(response: Home.Loading.Response())
    }
    
    func recievedFromDataBase(places: [Venue]) {
        self.presenter?.presentData(response: Home.List.Response(venues: places))
    }
}

// MARK: - Reachability Delegate
extension HomeInteractor: ReachabilityDelegate {
    func statusChangedToNotReachable() {
        if UserDefaults.standard.venueParams != nil {
            let error = NetworkErrors.noNetworkConnectivity
            let reponse = Home.ModuleError.Response(error: error)
            self.presenter?.presentError(response: reponse)
        }
    }
    
    func statusChangedToReachable() {
        let currentLocation = locationManager.getCurrentLocation()
        guard let latitude = currentLocation.lat,
            let longitude = currentLocation.lng else { return }
        // first get from database
        self.checkPlaceParamsInDisk(latitude: latitude, longitude: longitude)
    }
}

// MARK: - LocationManager Delegate
extension HomeInteractor: LocationManagerDelegate {
    func updateLocationManager(latitude: String, longitude: String) {
        HomeLogger.log(text: "latitude = \(latitude)")
        HomeLogger.log(text: "longitude = \(longitude)")
        self.checkPlaceParamsInDisk(latitude: latitude, longitude: longitude)
    }
    
    func showPermisionLocationAlert() {
        self.presenter?.hideLoading(response: Home.Loading.Response())
        self.presenter?.hideFooterLoading(response: Home.pagination.Response())
        self.presenter?.presentPermisionLocationAlert(response: Home.Location.Response())
    }
}
