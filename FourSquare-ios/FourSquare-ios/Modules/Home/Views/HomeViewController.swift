//
//  HomeViewController.swift
//  FourSquare-ios
//
//  Created by mohammadSaadat on 5/30/1399 AP.
//  Copyright (c) 1399 mohammad. All rights reserved.
//

import UIKit

protocol HomeDisplayLogic: class {
    func displayPermisionLocationAlert(viewModel: Home.Location.ViewModel)
    func displayError(viewModel: Home.ModuleError.ViewModel)
    func displayList(viewModel: Home.List.ViewModel)
    func displayFooterLoading(viewModel: Home.pagination.ViewModel)
    func hideFooterLoading(viewModel: Home.pagination.ViewModel)
    func displayLoading()
    func hideLoading()
}

class HomeViewController: UIViewController {
    // MARK: - Object lifecycle
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        fatalError("HomeViewController - Initialization using coder Not Allowed.")
    }
    
    init(factory: HomeFactory) {
        super.init(nibName: HomeViewController.nibName, bundle: nil)
        self.factory = factory
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
    
    lazy var remoteIndicator: UIActivityIndicatorView = {
        let indicator = UIActivityIndicatorView(style: .gray)
        indicator.hidesWhenStopped = true
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(customView: indicator)
        return indicator
    }()
    
    private lazy var footerActitvityIndicator: UIActivityIndicatorView = {
        let spinner = UIActivityIndicatorView(style: .gray)
        spinner.frame = CGRect(x: CGFloat(0), y: CGFloat(0), width: self.tableView.bounds.width, height: CGFloat(85))
        spinner.startAnimating()
        spinner.hidesWhenStopped = true
        return spinner
    }()
    
    private var pullToRefresh: UIRefreshControl!
    
    // MARK: - Outlets
       @IBOutlet private weak var tableView: DefaultTableView! {
           didSet {
               tableView.didSelectTableView = { [weak self] viewModel in
                   guard let self = self,
                       let itemCellViewModel = viewModel as? ItemCellViewModel,
                       let place = itemCellViewModel.getModel() as? Place else { return }
                   Home.log(text: "place = \(place)")
                   self.router?.navigateToDetail(place: place)
               }
           }
       }
}

// MARK: - View Controller

// MARK: Life Cycle
extension HomeViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setup()
        addPulltoRefresh()
        setupNavigationController()
        interactor?.getPlaceFromDB(request: Home.List.Request())
        interactor?.startHandleLocation(request: Home.Location.Request())
    }
}

// MARK: - Methods

// MARK: Private
private extension HomeViewController {
    // Setup
    func setup() {
        guard self.interactor == nil else { return }
        let viewController = self
        let locationManager = factory.makeTestModuleLocationManager()
        let service = factory.makeHomeService()
        let coreDataService = factory.makeTestModuleCoreDataService()
        let reachability = factory.makeTestModuleReachability()
        let worker = HomeWorker(service: service,
                                coreDataService: coreDataService,
                                reachability: reachability)
        let interactor = HomeInteractor(locationManager: locationManager,
                                        worker: worker,
                                        reachability: reachability)
        let presenter = HomePresenter()
        let router = HomeRouter()
        viewController.interactor = interactor
        viewController.router = router
        interactor.presenter = presenter
        presenter.viewController = viewController
        router.viewController = viewController
        router.dataStore = interactor
    }
    
    private func addPulltoRefresh() {
        pullToRefresh = UIRefreshControl()
        pullToRefresh.tintColor = .lightGray
        pullToRefresh.addTarget(self, action: #selector(refreshPage), for: .valueChanged)
        tableView.alwaysBounceVertical = true
        tableView.refreshControl = pullToRefresh
    }
    
    @objc private func refreshPage() {
        self.pullToRefresh.beginRefreshing()
        interactor?.refreshPage(request: Home.List.Request())
    }
    
    func setupNavigationController() {
        title = "Home"
    }
}

// MARK: Public
extension HomeViewController {}

// MARK: - Display Logic
extension HomeViewController: HomeDisplayLogic {
    func hideFooterLoading(viewModel: Home.pagination.ViewModel) {
        tableView.removeTableFooter()
    }
    
    func displayFooterLoading(viewModel: Home.pagination.ViewModel) {
        tableView.setTableFooter(footerActitvityIndicator)
    }
    
    func displayList(viewModel: Home.List.ViewModel) {
        let dataSource = DefaultTableViewDataSource(sections: viewModel.section, paginationDelegate: self)
        self.tableView.displayData(dataSource)
        
        if tableView.isTableViewEmpty() {
            self.tableView.showEmptyListView("empty_list_places".localized, icon: nil, buttonText: nil, buttonTapHandler: nil)
        }
        else {
            self.tableView.hideEmptyListView()
        }
    }
    
    func displayPermisionLocationAlert(viewModel: Home.Location.ViewModel) {
        let alertController = UIAlertController(title: "", message: "alert_location_dialog".localized, preferredStyle: .alert)
        let settingsAction = UIAlertAction(title: "settings_action_title".localized, style: .default) { _ -> Void in
            self.interactor?.settingButtonTappedOnLocationAlert(request: Home.LocationAlert.Request())
        }
        
        let cancelAction = UIAlertAction(title: "cancel_action_title".localized, style: .cancel, handler: nil)
        alertController.addAction(cancelAction)
        alertController.addAction(settingsAction)
        
        present(alertController, animated: true, completion: nil)
    }
    
    func displayLoading() {
        self.remoteIndicator.startAnimating()
    }
    
    func hideLoading() {
        self.remoteIndicator.stopAnimating()
        self.pullToRefresh.endRefreshing()
    }
    
    func displayError(viewModel: Home.ModuleError.ViewModel) {
        let okAction = UIAlertAction.init(title: "OK".localized, style: .cancel, handler: nil)
        self.presentMessege(title: "Error".localized, message: viewModel.error.localizedDescription, additionalActions: okAction, preferredStyle: .alert)
    }
}

// MARK: - Appearance
extension HomeViewController: Appearance {
    func setColor() {}
    
    func setFont() {}
}

// MARK: - Actions
extension HomeViewController {}

extension HomeViewController: PaginationProtocol {
    func loadNextPage() {
        let offset = 10
        let currentPage = (tableView.sections.first?.cells.count ?? 0)/offset
        HomeLogger.log(text: "currentPage = \(currentPage)")
        interactor?.fetchNextPage(request: Home.pagination.Request(currentPage: currentPage))
    }
}
