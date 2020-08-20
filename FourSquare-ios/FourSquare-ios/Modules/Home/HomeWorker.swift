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
private extension HomeWorker {}

// MARK: - Worker Logic
extension HomeWorker: HomeWorkerLogic {
    func setDelegate(with delegate: HomeWorkerDelegate) {
        self.delegate = delegate
    }
}

// MARK: - CoreDataService Delegate
extension HomeWorker: CoreDataServiceDelegate {
    func fetchedDataAfterSaved(places: [Venue]) {
        self.delegate?.recievedFromDataBase(places: places)
    }
}
