//
//  DetailService.swift
//  TRB
//
//  Created by mohammad on 8/18/20.
//  Copyright (c) 2020 RoundTableApps. All rights reserved.
//

import Foundation
import PromiseKit

final class DetailService {
    // MARK: - Object lifecycle
    init(networkManager: NetworkManagerProtocol) {
        self.networkManager = networkManager
        DetailLogger.logInit(owner: String(describing: DetailService.self))
    }
    
    // MARK: - Deinit
    deinit {
        DetailLogger.logDeinit(owner: String(describing: DetailService.self))
    }
    
    // MARK: - Properties
    
    // MARK: Private
    private let networkManager: NetworkManagerProtocol
}

// MARK: - Methods

// MARK: Public
extension DetailService {
    func getDetailVenuesFromRemote(params: DetailVenueParams) -> Promise<VenueDetailResponse> {
        return networkManager
            .request(DetailEndpoint.getDetailVenue(params: params))
            .recover(NetworkErrors.parseError)
    }
}
