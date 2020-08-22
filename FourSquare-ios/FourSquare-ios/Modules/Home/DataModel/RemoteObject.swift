//
//  RemoteObject.swift
//  FourSquare-ios
//
//  Created by mohammadSaadat on 5/30/1399 AP.
//  Copyright © 1399 mohammad. All rights reserved.
//

import Foundation

// MARK: - ForSquareObject
struct ForSquareObject: Codable {
    let meta: Meta?
    let forSquareObjectresponse: ForSquareObjectresponse?
    
    enum CodingKeys: String, CodingKey {
        case meta
        case forSquareObjectresponse = "response"
    }
}

// MARK: - Meta
struct Meta: Codable {
    let code: Int?
    let requestID: String?

    enum CodingKeys: String, CodingKey {
        case code
        case requestID = "requestId"
    }
}

// MARK: - Response
struct ForSquareObjectresponse: Codable {
    let suggestedFilters: SuggestedFilters?
    let suggestedRadius: Int?
    let headerLocation, headerFullLocation, headerLocationGranularity, query: String?
    let totalResults: Int?
    let suggestedBounds: SuggestedBounds?
    let groups: [Group]?
}

// MARK: - SuggestedFilters
struct SuggestedFilters: Codable {
    let header: String?
    let filters: [Filter]?
}

// MARK: - Filter
struct Filter: Codable {
    let name, key: String?
}

// MARK: - SuggestedBounds
struct SuggestedBounds: Codable {
    let ne, sw: Ne?
}

// MARK: - Ne
struct Ne: Codable {
    let lat, lng: Double?
}

// MARK: - Group
struct Group: Codable {
    let type, name: String?
    let items: [GroupItem]?
    let count: Int?
}

// MARK: - GroupItem
struct GroupItem: Codable {
    let reasons: Reasons?
    let venue: VenueRemote?
    let referralID: String?

    enum CodingKeys: String, CodingKey {
        case reasons, venue
        case referralID = "referralId"
    }
}

// MARK: - Reasons
struct Reasons: Codable {
    let count: Int?
    let items: [ReasonsItem]?
}

// MARK: - ReasonsItem
struct ReasonsItem: Codable {
    let summary, type, reasonName: String?
}

// MARK: - Venue
struct VenueRemote: Codable {
    let id, name: String?
    let contact: Contact?
    let location: Location?
    let categories: [Category]?
    let verified: Bool?
    let stats: Stats?
    let beenHere: BeenHere?
//    let photos: Photos
    let hereNow: HereNow?
    let venuePage: VenuePage?
    let delivery: Delivery?
}

extension VenueRemote {
    var address: String {
        return location?.address ?? ""
    }
    
    var lat: Double {
        return location?.lat ?? 0
    }
    
    var lng: Double {
        return location?.lng ?? 0
    }
}

// MARK: - Contact
struct Contact: Codable {
}

// MARK: - Location
struct Location: Codable {
    let address: String?
    let crossStreet: String?
    let lat, lng: Double?
    let distance: Int?
    let postalCode: String?
    let cc, city, state: String?
    let country: String?
    let formattedAddress: [String]?
}

// MARK: - Category
struct Category: Codable {
    let id, name, pluralName, shortName: String?
    let icon: CategoryIcon?
    let primary: Bool?
}

// MARK: - CategoryIcon
struct CategoryIcon: Codable {
    let iconPrefix: String?
    let suffix: String?

    enum CodingKeys: String, CodingKey {
        case iconPrefix = "prefix"
        case suffix
    }
}

extension CategoryIcon {
    var resourceString: String? {
        guard let iconPrefix = iconPrefix, let suffix = suffix else { return nil }
        return "\(iconPrefix)100\(suffix)"
    }
    
    var resource: URL? {
        guard let resourceString = resourceString else { return nil }
        return URL(string: resourceString)
    }
}

// MARK: - Stats
struct Stats: Codable {
    let tipCount, usersCount, checkinsCount, visitsCount: Int?
}

// MARK: - BeenHere
struct BeenHere: Codable {
    let count, lastCheckinExpiredAt: Int?
    let marked: Bool?
    let unconfirmedCount: Int?
}

// MARK: - HereNow
struct HereNow: Codable {
    let count: Int?
    let summary: String?
    let groups: [Group]?
}

// MARK: - VenuePage
struct VenuePage: Codable {
    let id: String?
}

// MARK: - Delivery
struct Delivery: Codable {
    let id: String?
    let url: String?
    let provider: Provider?
}

// MARK: - Provider
struct Provider: Codable {
    let name: String?
    let icon: ProviderIcon?
}

// MARK: - ProviderIcon
struct ProviderIcon: Codable {
    let iconPrefix: String?
    let sizes: [Int]?
    let name: String?

    enum CodingKeys: String, CodingKey {
        case iconPrefix = "prefix"
        case sizes, name
    }
}
