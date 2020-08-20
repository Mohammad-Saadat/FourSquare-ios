//
//  CellViewModel.swift
//  FourSquare-ios
//
//  Created by mohammadSaadat on 5/30/1399 AP.
//  Copyright © 1399 mohammad. All rights reserved.
//

import Foundation

protocol CellViewModel {
    var nibName: String {get}
    var reuseId: String {get}
    func getModel() -> Any?
}

protocol Binder {
    func bind(_ viewModel: Any)
}
extension Binder {
    func willDisplay(_ viewModel: Any) { }
}

class DefaultCellViewModel: CellViewModel {
    var nibName: String
    var reuseId: String
    var model: Any?
    
    internal init(nibName: String, reuseId: String, model: Any?) {
        self.nibName = nibName
        self.reuseId = reuseId
        self.model = model
    }
    
    func getModel() -> Any? {
        return model
    }
}

class DefaultCollectionTableCellViewModel {
    
}
