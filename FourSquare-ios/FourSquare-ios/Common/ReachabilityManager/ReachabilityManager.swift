//
//  ReachabilityManager.swift
//  FourSquare-ios
//
//  Created by mohammadSaadat on 5/30/1399 AP.
//  Copyright © 1399 mohammad. All rights reserved.
//

import Foundation
import Alamofire

protocol ReachabilityDelegate: class {
    func statusChangedToReachable()
    func statusChangedToNotReachable()
}

class Reachability {
    
    init() {
        debugPrint("LifeCycle ->" + String(describing: Reachability.self) + "init")
        startListening()
    }
    
    // MARK: - Deinit
    deinit {
        self.deinitVariables()
        debugPrint("LifeCycle ->" + String(describing: Reachability.self) + "deinit")
    }
    
    // MARK: Private
    private var reachAbilityManager: NetworkReachabilityManager? = NetworkReachabilityManager()
    
    // MARK: Public
    weak private var delegate: ReachabilityDelegate?
    public var isReachableNetwork: Bool {
        return reachAbilityManager?.isReachable ?? false
    }
}

// MARK: Private
private extension Reachability {
    func startListening() {
        debugPrint("startListening")
        self.reachAbilityManager?.startListening { [weak self] status in
            guard let `self` = self else { return }
            switch status {
            case .reachable(_):
                debugPrint("Reachability changed with reachable status")
                self.delegate?.statusChangedToReachable()
            case .notReachable:
                debugPrint("Reachability changed with notReachable status")
                self.delegate?.statusChangedToNotReachable()
            case .unknown:
                debugPrint("Reachability changed with unknown status")
            }
        }
    }
    
    func deinitVariables() {
        self.reachAbilityManager?.stopListening()
        self.reachAbilityManager = nil
    }
}

// MARK: Public
extension Reachability {
    func setDelegate(with delegate: ReachabilityDelegate) {
        self.delegate = delegate
    }

    func isReachable() -> Bool {
        return self.isReachableNetwork
    }
}
