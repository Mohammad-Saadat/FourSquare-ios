//
//  HomeFactory.swift
//  FourSquare-ios
//
//  Created by mohammadSaadat on 5/30/1399 AP.
//  Copyright (c) 1399 mohammad. All rights reserved.
//

import Foundation

typealias HomeFactory = HomeViewControllerFactory & HomeServiceFactory

protocol HomeViewControllerFactory {
    func makeHomeViewController() -> HomeViewController
}

protocol HomeServiceFactory {
    func makeHomeService() -> HomeService
}
