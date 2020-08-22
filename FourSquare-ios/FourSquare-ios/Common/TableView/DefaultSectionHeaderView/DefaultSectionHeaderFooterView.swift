//
//  DefaultSectionHeaderFooterView.swift
//  Boatingo
//
//  Created by Ali Motevali on 4/7/20.
//  Copyright © 2020 RoundTableApps. All rights reserved.
//

import UIKit

class DefaultSectionHeaderFooterView: UITableViewHeaderFooterView {
    @IBOutlet private weak var bgView: UIView! {
        didSet {
            self.bgView.backgroundColor = .darkGray
        }
    }

    func setBackgroundColor(_ color: UIColor) {
        self.bgView.backgroundColor = color
    }
}
