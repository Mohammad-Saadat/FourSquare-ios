//
//  DetailWorker.swift
//  TRB
//
//  Created by mohammad on 8/18/20.
//  Copyright (c) 2020 RoundTableApps. All rights reserved.
//

import UIKit
import PromiseKit

protocol DetailWorkerLogic {
    func fetchDetailVenues(parameters: DetailVenueParams) -> Promise<VenueDetailResponse>
}

class DetailWorker {
    // MARK: - Object lifecycle
    init(service: DetailService) {
        DetailLogger.logInit(owner: String(describing: DetailWorker.self))
        self.service = service
    }
    
    // MARK: - Deinit
    deinit {
        DetailLogger.logDeinit(owner: String(describing: DetailWorker.self))
    }
    
    // MARK: - Properties
    
    // MARK: Private
    private let service: DetailService
}

// MARK: - Methods

// MARK: Private
private extension DetailWorker {}

// MARK: - Worker Logic
extension DetailWorker: DetailWorkerLogic {
    func fetchDetailVenues(parameters: DetailVenueParams) -> Promise<VenueDetailResponse> {
        return Promise { seal in
            service.getDetailVenuesFromRemote(params: parameters)
                .done { response in
                    seal.fulfill(response)
            }
            .catch { error in
                seal.reject(error)
            }
        }
    }
}
