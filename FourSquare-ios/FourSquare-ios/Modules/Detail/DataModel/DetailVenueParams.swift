//
//  DetailPlaceParams.swift
//  TRB
//
//  Created by mohammadSaadat on 5/28/1399 AP.
//  Copyright © 1399 RoundTableApps. All rights reserved.
//

import Foundation

struct DetailVenueParams: Codable {
    let id: String
    let clientId = InfoDictionary.main.clientId
    let clientSecret = InfoDictionary.main.clientSecret
}

extension DetailVenueParams {
     var v: String {
        let currentDate = Date()
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "YYYYMMDD"
        let currentDateString = dateFormatter.string(from: currentDate)
//        return currentDateString
        return "20180323"
    }
}
