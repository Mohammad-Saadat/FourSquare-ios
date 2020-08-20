//
//  ItemCellViewModel.swift
//  TRB
//
//  Created by mohammad on 8/17/20.
//  Copyright © 2020 RoundTableApps. All rights reserved.
//

import Foundation

class ItemCellViewModel: DefaultCellViewModel {
    init(venue: Venue) {
        super.init(nibName: "ItemTableViewCell", reuseId: "ItemTableViewCell", model: venue)
    }
}
