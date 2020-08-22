//
//  DetailFactory.swift
//  TRB
//
//  Created by mohammad on 8/18/20.
//  Copyright (c) 2020 RoundTableApps. All rights reserved.
//

import Foundation

typealias DetailFactory = DetailViewControllerFactory & DetailServiceFactory

protocol DetailViewControllerFactory {
    func makeDetailViewController(venue: Venue) -> DetailViewController
}

protocol DetailServiceFactory {
    func makeDetailService() -> DetailService
}
