//
//  HomeViewController.swift
//  FourSquare-ios
//
//  Created by mohammadSaadat on 5/30/1399 AP.
//  Copyright (c) 1399 mohammad. All rights reserved.
//

import UIKit

protocol HomeDisplayLogic: class {}

class HomeViewController: UIViewController {
    // MARK: - Object lifecycle
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        fatalError("HomeViewController - Initialization using coder Not Allowed.")
    }
    
    init(factory: HomeFactory) {
        super.init(nibName: HomeViewController.nibName, bundle: nil)
        self.factory = factory
        setup()
        HomeLogger.logInit(owner: String(describing: HomeViewController.self))
    }
    
    // MARK: - Deinit
    deinit {
        HomeLogger.logDeinit(owner: String(describing: HomeViewController.self))
    }
    
    // MARK: - Properties
    
    // MARK: Private
    private var factory: HomeFactory!
    
    // MARK: Public
    var interactor: HomeBusinessLogic?
    var router: (NSObjectProtocol & HomeRoutingLogic & HomeDataPassing)?
    
    // MARK: - Outlets
}

// MARK: - View Controller

// MARK: Life Cycle
extension HomeViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setup()
    }
}

// MARK: - Methods

// MARK: Private
private extension HomeViewController {
    // Setup
    func setup() {
        guard self.interactor == nil else { return }
        let viewController = self
        let interactor = HomeInteractor()
        let presenter = HomePresenter()
        let router = HomeRouter()
        let worker = HomeWorker(service: factory.makeHomeService())
        viewController.interactor = interactor
        viewController.router = router
        interactor.presenter = presenter
        interactor.worker = worker
        presenter.viewController = viewController
        router.viewController = viewController
        router.dataStore = interactor
    }
}

// MARK: Public
extension HomeViewController {}

// MARK: - Display Logic
extension HomeViewController: HomeDisplayLogic {}

// MARK: - Appearance
extension HomeViewController: Appearance {
    func setColor() {}
    
    func setFont() {}
}

// MARK: - Actions
extension HomeViewController {}
