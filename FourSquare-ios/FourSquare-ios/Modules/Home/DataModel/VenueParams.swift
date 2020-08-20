//
//  File.swift
//  FourSquare-ios
//
//  Created by mohammadSaadat on 5/30/1399 AP.
//  Copyright © 1399 mohammad. All rights reserved.
//

import Foundation

struct VenueParams: Codable {
    var latitude: String
    var longitude: String
    let limit: Int = 10
    var page: Int = 1
    let clientId = InfoDictionary.main.clientId
    let clientSecret = InfoDictionary.main.clientSecret
}

extension VenueParams {
     var v: String {
        let currentDate = Date()
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "YYYYMMDD"
        let currentDateString = dateFormatter.string(from: currentDate)
//        return currentDateString
        return "20180323"
    }
    
    var ll: String {
        return [latitude, longitude].compactMap { $0 }.joined(separator: ",")
    }
    
    var offset: Int {
        let offset = limit * (page - 1)
        debugPrint("offset = \(offset)")
        return (offset > 0) ? offset : 0
    }
}
