//
//  DetailViewController.swift
//  TRB
//
//  Created by mohammad on 8/18/20.
//  Copyright (c) 2020 RoundTableApps. All rights reserved.
//

import UIKit
import Toast_Swift

protocol DetailDisplayLogic: class {
    func displayError(viewModel: Detail.ModuleError.ViewModel)
    func presentFromDB(response: Detail.FromDataBase.ViewModel)
    func presentFromRemote(response: Detail.FromRemote.ViewModel)
    func displayLoading()
    func hideLoading()
}

class DetailViewController: UIViewController {
    // MARK: - Object lifecycle
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        fatalError("DetailViewController - Initialization using coder Not Allowed.")
    }
    
    init(factory: DetailFactory) {
        super.init(nibName: DetailViewController.nibName, bundle: nil)
        self.factory = factory
        self.setup()
        DetailLogger.logInit(owner: String(describing: DetailViewController.self))
    }
    
    // MARK: - Deinit
    deinit {
        DetailLogger.logDeinit(owner: String(describing: DetailViewController.self))
    }
    
    // MARK: - Properties
    
    // MARK: Private
    private var factory: DetailFactory!
    
    // MARK: Public
    var interactor: DetailBusinessLogic?
    var router: (NSObjectProtocol & DetailRoutingLogic & DetailDataPassing)?
    
    lazy var remoteIndicator: UIActivityIndicatorView = {
        let indicator = UIActivityIndicatorView(style: .gray)
        indicator.hidesWhenStopped = true
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(customView: indicator)
        return indicator
    }()
    
    // MARK: - Outlets
    @IBOutlet private weak var categoryIcon: UIImageView!
    @IBOutlet private weak var venueIcon: UIImageView! {
        didSet {
            venueIcon.addCornerRadius(10)
        }
    }
    
    @IBOutlet private weak var categoryLabel: UILabel!
    @IBOutlet private weak var nameLabel: UILabel!
    @IBOutlet private weak var rateLabel: UILabel!
    @IBOutlet private weak var likePersonLabel: UILabel!
    @IBOutlet private weak var addressLabel: UILabel!
    
    @IBOutlet private weak var rateBackgroundView: UIView! {
        didSet {
            rateBackgroundView.circle()
        }
    }
    
}

// MARK: - View Controller

// MARK: Life Cycle
extension DetailViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        setupNavigationController()
        interactor?.fetchDetalPlace(request: Detail.DetailPlace.Request())
    }
}

// MARK: - Methods

// MARK: Private
private extension DetailViewController {
    // Setup
    func setup() {
        let viewController = self
        let interactor = DetailInteractor()
        let presenter = DetailPresenter()
        let router = DetailRouter()
        let worker = DetailWorker(service: factory.makeDetailService())
        viewController.interactor = interactor
        viewController.router = router
        interactor.presenter = presenter
        interactor.worker = worker
        presenter.viewController = viewController
        router.viewController = viewController
        router.dataStore = interactor
    }
    
    func setupNavigationController() {
        title = "Detail"
    }
}

// MARK: Public
extension DetailViewController {}

// MARK: - Display Logic
extension DetailViewController: DetailDisplayLogic {
    func presentFromDB(response: Detail.FromDataBase.ViewModel) {
        let venue = response.venue
        nameLabel.text = venue.name
        addressLabel.text = venue.address
        categoryLabel.text = venue.categoryName
        if let categoryURL = venue.categoryURL, let url = URL(string: categoryURL) {
            categoryIcon.setImage(with: url, placeholder: #imageLiteral(resourceName: "shop")) { [weak self] result in
                guard let `self` = self else { return }
                switch result {
                case .success(let value):
                    self.categoryIcon.image = value.image.withRenderingMode(.alwaysTemplate)
                    self.categoryIcon.tintColor = UIColor.black
                case .failure(_):
                    break
                }
            }
        }
    }
    
    func presentFromRemote(response: Detail.FromRemote.ViewModel) {
        let venueDetail = response.venueDetail
        
        nameLabel.text = venueDetail.name
        if let address = venueDetail.location?.address, !address.isEmpty {
            addressLabel.text = address
        }
        
        let category = venueDetail.categories?.first
        categoryLabel.text = category?.name
        categoryIcon.setImage(with: category?.icon?.resource, placeholder: #imageLiteral(resourceName: "shop")) { [weak self] result in
            guard let `self` = self else { return }
            switch result {
            case .success(let value):
                self.categoryIcon.image = value.image.withRenderingMode(.alwaysTemplate)
                self.categoryIcon.tintColor = UIColor.black
            case .failure(_):
                break
            }
        }
        
        let photoes = venueDetail.photos?.groups?.first?.items?.first
        venueIcon.setImage(with: photoes?.resource, placeholder: #imageLiteral(resourceName: "places"))
        
        rateBackgroundView.backgroundColor = UIColor(hexString: "#\(venueDetail.ratingColor ?? "")")
        rateLabel.text = venueDetail.rating?.string
        likePersonLabel.text = venueDetail.likes?.summary
    }
    
    func displayError(viewModel: Detail.ModuleError.ViewModel) {
        if let error = viewModel.error as? NetworkErrors,
            case NetworkErrors.noNetworkConnectivity = error {
            self.view.makeToast(error.localizedDescription, duration: 2.0, position: .bottom)
        } else {
            let okAction = UIAlertAction.init(title: "OK".localized, style: .cancel, handler: nil)
            self.presentMessege(title: "Error".localized, message: viewModel.error.localizedDescription, additionalActions: okAction, preferredStyle: .alert)
        }
    }
    
    func displayLoading() {
         self.remoteIndicator.startAnimating()
    }
    
    func hideLoading() {
         self.remoteIndicator.stopAnimating()
    }
}

// MARK: - Appearance
extension DetailViewController: Appearance {
    func setColor() {}
    
    func setFont() {}
}

// MARK: - Actions
extension DetailViewController {}
