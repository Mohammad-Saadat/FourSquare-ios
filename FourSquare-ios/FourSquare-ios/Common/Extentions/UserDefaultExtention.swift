//
//  UserDefaultExtention.swift
//  FourSquare-ios
//
//  Created by mohammadSaadat on 5/30/1399 AP.
//  Copyright © 1399 mohammad. All rights reserved.
//

import Foundation

enum UserDefaultsKey: String {
    case venueParams
}

extension UserDefaults {
    var venueParams: VenueParams? {
        get {
            guard let object = UserDefaults.standard.object(forKey: UserDefaultsKey.venueParams.rawValue) as? Data else { return nil }
            do {
                let user = try JSONDecoder().getInstance().decode(VenueParams.self, from: object)
                return user
            } catch let error {
                debugPrint(error.localizedDescription)
                return nil
            }
        }
        set {
            if let venueParams: VenueParams = newValue {
                do {
                    let encoded = try JSONEncoder().getInstance().encode(venueParams)
                    set(encoded, forKey: UserDefaultsKey.venueParams.rawValue)
                } catch let error {
                    debugPrint(error.localizedDescription)
                }
                
            } else {
                removeObject(forKey: UserDefaultsKey.venueParams.rawValue)
            }
        }
    }
}
