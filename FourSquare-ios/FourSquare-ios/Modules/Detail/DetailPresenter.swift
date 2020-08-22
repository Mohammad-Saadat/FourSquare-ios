//
//  DetailPresenter.swift
//  TRB
//
//  Created by mohammad on 8/18/20.
//  Copyright (c) 2020 RoundTableApps. All rights reserved.
//

import UIKit

protocol DetailPresentationLogic {
    func presentError(response: Detail.ModuleError.Response)
    func presentLoading(response: Detail.Loading.Response)
    func hideLoading(response: Detail.Loading.Response)
    func presentFromDB(response: Detail.FromDataBase.Response)
    func presentFromRemote(response: Detail.FromRemote.Response)
}

class DetailPresenter {
    // MARK: - Object lifecycle
    init() {
        DetailLogger.logInit(owner: String(describing: DetailPresenter.self))
    }
    
    // MARK: - Deinit
    deinit {
        DetailLogger.logDeinit(owner: String(describing: DetailPresenter.self))
    }
    
    // MARK: - Properties
    
    // MARK: Public
    weak var viewController: DetailDisplayLogic?
}

// MARK: - Methods

// MARK: Private
private extension DetailPresenter {}

// MARK: Public
extension DetailPresenter {}

// MARK: - Presentation Logic
extension DetailPresenter: DetailPresentationLogic {
    func presentFromDB(response: Detail.FromDataBase.Response) {
        DispatchQueue.main.async {
            self.viewController?.presentFromDB(response: Detail.FromDataBase.ViewModel(venue: response.venue))
        }
    }
    
    func presentFromRemote(response: Detail.FromRemote.Response) {
        DispatchQueue.main.async {
            self.viewController?.presentFromRemote(response: Detail.FromRemote.ViewModel(venueDetail: response.venueDetail))
        }
    }
    
    func presentError(response: Detail.ModuleError.Response) {
        DispatchQueue.main.async {
            self.viewController?.displayError(viewModel: Detail.ModuleError.ViewModel(error: response.error))
        }
    }
    
    func presentLoading(response: Detail.Loading.Response) {
        DispatchQueue.main.async {
            self.viewController?.displayLoading()
        }
    }
    
    func hideLoading(response: Detail.Loading.Response) {
        DispatchQueue.main.async {
            self.viewController?.hideLoading()
        }
    }
}
