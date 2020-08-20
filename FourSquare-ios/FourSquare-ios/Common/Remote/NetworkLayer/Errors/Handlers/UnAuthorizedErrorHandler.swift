//
//  UnAuthorizedErrorHandler.swift
//  FourSquare-ios
//
//  Created by mohammadSaadat on 5/30/1399 AP.
//  Copyright © 1399 mohammad. All rights reserved.
//

import Foundation

class UnAuthorizedErrorHandler: ErrorHandlerProtocol {
    let error: GeneralErrors
    
    init(error: GeneralErrors) {
        self.error = error
    }
    
    func handleError() {
        guard case GeneralErrors.unAuthorized(messages: _) = error else { return }

    }

}
