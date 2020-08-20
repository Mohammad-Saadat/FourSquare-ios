//
//  DetailInteractor.swift
//  TRB
//
//  Created by mohammad on 8/18/20.
//  Copyright (c) 2020 RoundTableApps. All rights reserved.
//

import UIKit

protocol DetailBusinessLogic {
    func fetchDetalPlace(request: Detail.DetailPlace.Request)
}

protocol DetailDataStore {
    var venue: Venue? { get set }
}

class DetailInteractor: DetailDataStore {
    // MARK: - Object lifecycle
    init() {
        DetailLogger.logInit(owner: String(describing: DetailInteractor.self))
    }
    
    // MARK: - Deinit
    deinit {
        DetailLogger.logDeinit(owner: String(describing: DetailInteractor.self))
    }
    
    // MARK: - Properties
    
    // MARK: Public
    var presenter: DetailPresentationLogic?
    var worker: DetailWorkerLogic?
    var venue: Venue?
}

// MARK: - Methods

// MARK: Private
private extension DetailInteractor {}

// MARK: Public
extension DetailInteractor {}

// MARK: - Business Logics
extension DetailInteractor: DetailBusinessLogic {
    func fetchDetalPlace(request: Detail.DetailPlace.Request) {        
        guard let venue = self.venue, let venueId = venue.id else { return }
        
        self.presenter?.presentFromDB(response: Detail.FromDataBase.Response(venue: venue))
        let params = DetailVenueParams(id: venueId)
        self.presenter?.presentLoading(response: Detail.Loading.Response())
        self.worker?.fetchDetailVenues(parameters: params)
            .done { [weak self] response in
                    guard let `self` = self,
                        let venueDetail = response.forSquareDetailObjectresponse?.venueDetail else { return }
                    
                self.presenter?.presentFromRemote(response: Detail.FromRemote.Response(venueDetail: venueDetail))
            }
            .catch { [weak self] error in
                guard let `self` = self else { return }
                self.presenter?.presentError(response: Detail.ModuleError.Response(error: error))
            }
            .finally { [weak self] in
                guard let `self` = self else { return }
                self.presenter?.hideLoading(response: Detail.Loading.Response())
            }
    }
}
