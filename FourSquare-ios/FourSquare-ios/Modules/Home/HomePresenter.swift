//
//  HomePresenter.swift
//  FourSquare-ios
//
//  Created by mohammadSaadat on 5/30/1399 AP.
//  Copyright (c) 1399 mohammad. All rights reserved.
//

import UIKit

protocol HomePresentationLogic {
    func presentPermisionLocationAlert(response: Home.Location.Response)
    func presentError(response: Home.ModuleError.Response)
    func presentLoading(response: Home.Loading.Response)
    func presentFooterLoading(response: Home.pagination.Response)
    func hideFooterLoading(response: Home.pagination.Response)
    func hideLoading(response: Home.Loading.Response)
    func presentData(response: Home.List.Response)
}

class HomePresenter {
    // MARK: - Object lifecycle
    init() {
        HomeLogger.logInit(owner: String(describing: HomePresenter.self))
    }
    
    // MARK: - Deinit
    deinit {
        HomeLogger.logDeinit(owner: String(describing: HomePresenter.self))
    }
    
    // MARK: - Properties
    
    // MARK: Public
    weak var viewController: HomeDisplayLogic?
}

// MARK: - Methods

// MARK: Private
private extension HomePresenter {
    func createSections(places: [Venue]) -> SectionViewModel {
           let cells = places.map { ItemCellViewModel(place: $0) }
           let section = DefaultSection(cells: cells)
           return section
       }
}

// MARK: Public
extension HomePresenter {}

// MARK: - Presentation Logic
extension HomePresenter: HomePresentationLogic {
    func hideFooterLoading(response: Home.pagination.Response) {
           DispatchQueue.main.async {
               self.viewController?.hideFooterLoading(viewModel: Home.pagination.ViewModel())
           }
       }
       
       func presentFooterLoading(response: Home.pagination.Response) {
           DispatchQueue.main.async {
               self.viewController?.displayFooterLoading(viewModel: Home.pagination.ViewModel())
           }
       }
       
       func presentData(response: Home.List.Response) {
           let section = createSections(places: response.places)
           let viewModel = Home.List.ViewModel(section: [section])
           DispatchQueue.main.async {
               self.viewController?.displayList(viewModel: viewModel)
           }
       }
       
       func presentLoading(response: Home.Loading.Response) {
           DispatchQueue.main.async {
               self.viewController?.displayLoading()
           }
       }
       
       func hideLoading(response: Home.Loading.Response) {
           DispatchQueue.main.async {
               self.viewController?.hideLoading()
           }
       }
       
       func presentError(response: Home.ModuleError.Response) {
           DispatchQueue.main.async {
               self.viewController?.displayError(viewModel: Home.ModuleError.ViewModel(error: response.error))
           }
       }
       
       func presentPermisionLocationAlert(response: Home.Location.Response) {
           DispatchQueue.main.async {
               self.viewController?.displayPermisionLocationAlert(viewModel: Home.Location.ViewModel())
           }
       }
}
