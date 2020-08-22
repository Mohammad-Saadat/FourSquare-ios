//
//  ItemTableViewCell.swift
//  TRB
//
//  Created by mohammad on 8/17/20.
//  Copyright © 2020 RoundTableApps. All rights reserved.
//

import UIKit

class ItemTableViewCell: UITableViewCell {
    // ==================
    // MARK: - Properties
    // ==================
    
    // MARK: Private
    
    // ===============
    // MARK: - Outlets
    // ===============
    
    // MARK: Labels
    @IBOutlet private weak var nameLabel: UILabel!
    @IBOutlet private weak var addressLabel: UILabel!
    @IBOutlet private weak var categoryNameLabel: UILabel!
    @IBOutlet private weak var categoryIcon: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
}

extension ItemTableViewCell: Binder {
    func bind(_ viewModel: Any) {
        if let viewModel = viewModel as? ItemCellViewModel,
            let model = viewModel.getModel() as? Venue {
            setup(with: model)
        }
    }
}

private extension ItemTableViewCell {
    func setup(with model: Venue) {
        nameLabel.text = model.name
        addressLabel.text = model.address
        categoryNameLabel.text = model.categoryName
        setCategoryIcon(with: model.categoryURL)
    }
    
    func setCategoryIcon(with stringUrl: String?) {
        if let stringUrl = stringUrl, let url = URL(string: stringUrl) {
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
        } else {
            categoryIcon.isHidden = true
        }
    }
}
