//
//  HomeWorker.swift
//  FourSquare-ios
//
//  Created by mohammadSaadat on 5/30/1399 AP.
//  Copyright (c) 1399 mohammad. All rights reserved.
//

import UIKit
import PromiseKit

protocol HomeWorkerDelegate: class {
    func handeleError(error: Error)
    func startRemoteIndicator()
    func stopRemoteIndicator()
    func startFooterIndicator()
    func stopFooterIndicator()
    func recievedFromDataBase(places: [Venue])
}

protocol HomeWorkerLogic {
    func setDelegate(with delegate: HomeWorkerDelegate)
    func fetchPlaces(params: VenueParams)
    func fetchPlacesFromDB()
    func fetchForPagination(params: VenueParams)
}

class HomeWorker {
    // MARK: - Object lifecycle
    init(service: HomeService,
         coreDataService: CoreDataService,
         reachability: Reachability) {
        HomeLogger.logInit(owner: String(describing: HomeWorker.self))
        self.service = service
        self.coreDataService = coreDataService
        self.reachability = reachability
        self.coreDataService.setDelegate(with: self)
    }
    
    // MARK: - Deinit
    deinit {
        HomeLogger.logDeinit(owner: String(describing: HomeWorker.self))
    }
    
    // MARK: - Properties
    
    // MARK: Private
    private let service: HomeService
    private let coreDataService: CoreDataService
    private let reachability: Reachability
    //
    private var lastPlaceParams: VenueParams?
    private var remoteCallInprogress: Atomic<Bool> = Atomic<Bool>(false)
    private var getFromRemoteWithActiveConnection: Bool {
        let result = self.reachability.isReachable() && !self.remoteCallInprogress.value
        HomeLogger.log(text: "getFromRemoteWithActiveConnection = \(result)")
        return result
    }
    
    // MARK: Public
    private weak var delegate: HomeWorkerDelegate?
}

// MARK: - Methods

// MARK: Private
private extension HomeWorker {
    func fetchFromRemote(params: VenueParams) {
        self.remoteCallInprogress.mutate { $0 = true }
        self.delegate?.startRemoteIndicator()
        //
        service.getVenuesFromRemote(params: params)
            .get{ [weak self] result in
                guard let `self` = self else { return }
                try self.coreDataService.deleteAllRecords()
        }
        .get { [weak self] result in
            guard let `self` = self,
                let items = result.forSquareObjectresponse?.groups?.first?.items else { return }
            let venus = items.compactMap { $0.venue }
            HomeLogger.log(text: "venus = \(venus)")
            try self.coreDataService.save(with: venus)
        }
        .done { _ in
            UserDefaults.standard.venueParams = params
        }
        .catch { [weak self] error in
            guard let `self` = self else { return }
            HomeLogger.log(text: "error = \(error)")
            self.delegate?.handeleError(error: error)
        }
        .finally { [weak self] in
            guard let `self` = self else { return }
            self.delegate?.stopRemoteIndicator()
            self.remoteCallInprogress.mutate { $0 = false }
        }
    }
    
    func fetchFromDataBase() {
        do {
            let persons = try self.coreDataService.fetchAllData()
            self.delegate?.recievedFromDataBase(places: persons)
        } catch {
            HomeLogger.log(text: "error in fetchFromDataBase = \(error)")
            self.delegate?.handeleError(error: error)
        }
    }
    
    func checkConditionForGetRemoteData(params: VenueParams) {
        if getFromRemoteWithActiveConnection {
            fetchFromRemote(params: params)
        } else {
            if !self.reachability.isReachable() {
                delegate?.handeleError(error: NetworkErrors.noNetworkConnectivity)
            }
        }
    }
}

// MARK: - Worker Logic
extension HomeWorker: HomeWorkerLogic {
    func fetchForPagination(params: VenueParams) {
        self.remoteCallInprogress.mutate { $0 = true }
        self.delegate?.startFooterIndicator()
        
        service.getVenuesFromRemote(params: params)
            .get { [weak self] result in
                guard let `self` = self,
                    let items = result.forSquareObjectresponse?.groups?.first?.items else { return }
                let venus = items.compactMap { $0.venue }
                HomeLogger.log(text: "venus = \(venus)")
                try self.coreDataService.save(with: venus)
        }
        .done { _ in
            UserDefaults.standard.venueParams = params
        }
        .catch { [weak self] error in
            guard let `self` = self else { return }
            HomeLogger.log(text: "error = \(error)")
            self.delegate?.handeleError(error: error)
        }
        .finally { [weak self] in
            guard let `self` = self else { return }
            self.delegate?.stopFooterIndicator()
            self.remoteCallInprogress.mutate { $0 = false }
        }
    }
    
    func setDelegate(with delegate: HomeWorkerDelegate) {
        self.delegate = delegate
    }
    
    func fetchPlaces(params: VenueParams) {
        checkConditionForGetRemoteData(params: params)
    }
    
    func fetchPlacesFromDB() {
        fetchFromDataBase()
    }
}

// MARK: - CoreDataService Delegate
extension HomeWorker: CoreDataServiceDelegate {
    func fetchedDataAfterSaved(places: [Venue]) {
        self.delegate?.recievedFromDataBase(places: places)
    }
}
