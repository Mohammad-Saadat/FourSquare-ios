//
//  HomeModels.swift
//  FourSquare-ios
//
//  Created by mohammadSaadat on 5/30/1399 AP.
//  Copyright (c) 1399 mohammad. All rights reserved.
//

import UIKit

enum Home {
    enum Location {
        struct Request {
        }
        struct Response {
        }
        struct ViewModel {
        }
    }
    
    enum LocationAlert {
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
    
    enum List {
        struct Request {
        }
        struct Response {
            let venues: [Venue]
        }
        struct ViewModel {
            let section: [SectionViewModel]
        }
    }
    
    enum pagination {
        struct Request {
            let currentPage: Int
        }
        struct Response {
        }
        struct ViewModel {
        }
    }
}
