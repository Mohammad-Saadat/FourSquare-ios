//
//  DetailModels.swift
//  TRB
//
//  Created by mohammad on 8/18/20.
//  Copyright (c) 2020 RoundTableApps. All rights reserved.
//

import UIKit

enum Detail {
    // MARK: Use cases
    
    enum DetailPlace {
        struct Request {
        }
        struct Response {
        }
        struct ViewModel {
        }
    }
    
    enum ModuleError {
       struct Request {
        }
        struct Response {
            var error: Error
        }
        struct ViewModel {
            var error: Error
        }
    }
    
    enum Loading {
       struct Request {
        }
        struct Response {
        }
        struct ViewModel {
        }
    }
    
    enum FromRemote {
        struct Request {
        }
        struct Response {
            let venueDetail: VenueDetail
        }
        struct ViewModel {
            let venueDetail: VenueDetail
        }
    }
    
    enum FromDataBase {
        struct Request {
        }
        struct Response {
            let venue: Venue
        }
        struct ViewModel {
            let venue: Venue
        }
    }
}
