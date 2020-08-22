//
//  SectionViewModel.swift
//  FourSquare-ios
//
//  Created by mohammadSaadat on 5/30/1399 AP.
//  Copyright © 1399 mohammad. All rights reserved.
//

import Foundation
import UIKit

protocol SectionViewModel {
    var cells: [CellViewModel] {get}

    func getHeaderReuseId() -> String?
    func getHeaderNibName() -> String?
    func getHeaderHeight() -> CGFloat?
    func getHeaderExpanded() -> Bool
    func setHeaderExpanded(value: Bool)
    func getHeaderModel() -> Any?

    func getFooterReuseId() -> String?
    func getFooterNibName() -> String?
    func getFooterHeight() -> CGFloat?
    func getFooterModel() -> Any?

    func appendCells(cells: [CellViewModel])
    func deleteCells(indices: [Int])
    func updateCell(cellIndex: Int, newValue: CellViewModel)
}

extension SectionViewModel {

    func getHeaderReuseId() -> String? {
        return nil
    }

    func getHeaderNibName() -> String? {
        return ""
    }

    func getHeaderHeight() -> CGFloat? {
        return CGFloat.leastNonzeroMagnitude
    }

    func getHeaderModel() -> Any? {
        return nil
    }

    func getFooterReuseId() -> String? {
        return nil
    }

    func getFooterNibName() -> String? {
        return ""
    }

    func getFooterHeight() -> CGFloat? {
        return CGFloat.leastNonzeroMagnitude
    }

    func getFooterModel() -> Any? {
        return nil
    }

}

class DefaultSection: SectionViewModel {
    var cells: [CellViewModel]

    var sectionHeaderReuseId: String?
    var sectionHeaderNibName: String?
    var sectionHeaderHeight: CGFloat?
    var sectionHeaderExpanded: Bool?
    var sectionHeaderModel: Any?

    var sectionFooterReuseId: String?
    var sectionFooterNibName: String?
    var sectionFooterHeight: CGFloat?
    var sectionFooterModel: Any?

    init(cells: [CellViewModel]) {
        self.cells = cells
    }

    func setHeaderValues(_ reuseId: String, nibName: String, height: CGFloat, model: Any?, isExpandable: Bool? = false) {
        self.sectionHeaderModel = model
        self.sectionHeaderHeight = height
        self.sectionHeaderReuseId = reuseId
        self.sectionHeaderNibName = nibName
        if let isExpandable = isExpandable {
            self.sectionHeaderExpanded = !isExpandable
        }
    }

    func setFooterValues(_ reuseId: String, nibName: String, height: CGFloat, model: Any?) {
        self.sectionFooterModel = model
        self.sectionFooterHeight = height
        self.sectionFooterReuseId = reuseId
        self.sectionFooterNibName = nibName
    }
    
    func getHeaderExpanded() -> Bool {
        return sectionHeaderExpanded ?? true
    }
    
    func setHeaderExpanded(value: Bool) {
        self.sectionHeaderExpanded = value
    }

    func appendCells(cells: [CellViewModel]) {
        self.cells.append(contentsOf: cells)
    }

    func deleteCells(indices: [Int]) {
        indices.forEach {self.cells.remove(at: $0)}
    }

    func updateCell(cellIndex: Int, newValue: CellViewModel) {
        self.cells[cellIndex] = newValue
    }
}

extension DefaultSection {
    func getHeaderReuseId() -> String? {
        return sectionHeaderReuseId ?? "DefaultSectionHeaderFooterView"
    }

    func getHeaderNibName() -> String? {
        return sectionHeaderNibName ?? "DefaultSectionHeaderFooterView"
    }

    func getHeaderHeight() -> CGFloat? {
        return sectionHeaderHeight ?? CGFloat.leastNonzeroMagnitude
    }

    func getHeaderModel() -> Any? {
        return sectionHeaderModel
    }

    func getFooterReuseId() -> String? {
        return sectionFooterReuseId
    }

    func getFooterNibName() -> String? {
        return sectionFooterNibName
    }

    func getFooterHeight() -> CGFloat? {
        return sectionFooterHeight ?? CGFloat.leastNonzeroMagnitude
    }

    func getFooterModel() -> Any? {
        return sectionFooterModel
    }
}
