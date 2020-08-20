//
//  ForSquareDetailObject.swift
//  TRB
//
//  Created by mohammadSaadat on 5/28/1399 AP.
//  Copyright © 1399 RoundTableApps. All rights reserved.
//

import Foundation

// MARK: - ForSquareDetailObject
struct VenueDetailResponse: Codable {
    let meta: Meta?
    let forSquareDetailObjectresponse: ForSquareDetailObjectresponse?
    
    enum CodingKeys: String, CodingKey {
        case meta
        case forSquareDetailObjectresponse = "response"
    }
}

// MARK: - Response
struct ForSquareDetailObjectresponse: Codable {
    let venueDetail: VenueDetail?
    enum CodingKeys: String, CodingKey {
        case venueDetail = "venue"
    }
}

// MARK: - Venue
struct VenueDetail: Codable {
    let id, name: String?
    let contact: Contact?
    let location: Location?
    let canonicalURL: String?
    let categories: [Category]?
    let verified: Bool?
    let stats: Stats?
    let likes: HereNow?
    let dislike, ok: Bool?
    let rating: Double?
    let ratingColor: String?
    let ratingSignals: Int?
    let allowMenuURLEdit: Bool?
    let beenHere: BeenHere?
    let specials: Inbox?
    let photos: Listed?
    let reasons: Inbox?
    let hereNow: HereNow?
    let createdAt: Int?
    let tips: Listed?
    let shortURL: String?
    let timeZone: String?
    let listed: Listed?
    let pageUpdates, inbox: Inbox?

    enum CodingKeys: String, CodingKey {
        case id, name, contact, location
        case canonicalURL = "canonicalUrl"
        case categories, verified, stats, likes, dislike, ok, rating, ratingColor, ratingSignals
        case allowMenuURLEdit = "allowMenuUrlEdit"
        case beenHere, specials, photos, reasons, hereNow, createdAt, tips
        case shortURL = "shortUrl"
        case timeZone, listed, pageUpdates, inbox
    }
}

// MARK: - Inbox
struct Inbox: Codable {
    let count: Int?
    let items: [InboxItem]?
}

// MARK: - InboxItem
struct InboxItem: Codable {
    let summary, type, reasonName: String?
}

// MARK: - Listed
struct Listed: Codable {
    let count: Int?
    let groups: [HereNowGroup]?
}

// MARK: - HereNowGroup
struct HereNowGroup: Codable {
    let type: String?
    let count: Int?
    let items: [FluffyItem]?
    let name: String?
}

// MARK: - FluffyItem
struct FluffyItem: Codable {
    let id, name, itemDescription, type: String?
    let editable, itemPublic, collaborative: Bool?
    let url: String?
    let canonicalURL: String?
    let createdAt, updatedAt: Int?
    let listItems: Inbox?
    let itemPrefix: String?
    let suffix: String?
    let width, height: Int?
    let visibility, text, lang: String?
    let likes: HereNow?
    let logView: Bool?
    let agreeCount, disagreeCount: Int?
    let firstName, lastName: String?

    enum CodingKeys: String, CodingKey {
        case id, name
        case itemDescription = "description"
        case type, editable
        case itemPublic = "public"
        case collaborative, url
        case canonicalURL = "canonicalUrl"
        case createdAt, updatedAt, listItems
        case itemPrefix = "prefix"
        case suffix, width, height, visibility, text, lang, likes, logView, agreeCount, disagreeCount, firstName, lastName
    }
}

extension FluffyItem {
    var resource: URL? {
        guard let itemPrefix = itemPrefix, let suffix = suffix else { return nil }
        return URL(string: "\(itemPrefix)200x200\(suffix)")
    }
}
