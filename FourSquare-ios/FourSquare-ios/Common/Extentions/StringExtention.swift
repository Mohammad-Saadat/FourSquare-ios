//
//  StringExtention.swift
//  FourSquare-ios
//
//  Created by mohammadSaadat on 5/30/1399 AP.
//  Copyright © 1399 mohammad. All rights reserved.
//

import Foundation
import UIKit

extension String {
    var utf8Data: Data {
        guard let data = data(using: .utf8) else {
            fatalError("Could not convert string to data with encoding utf8")
        }
        return data
    }
    
    var double: Double {
        return Double(self) ?? 0
    }
    
    var float: Float {
        return Float(self) ?? 0
    }
    
    var int: Int? {
        return Int(self)
    }
    
    var firstUppercased: String {
        return prefix(1).uppercased()  + dropFirst()
    }
    var firstCapitalized: String {
        return prefix(1).capitalized + dropFirst()
    }
    
    var localized: String {
        return NSLocalizedString(self, tableName: nil, bundle: Bundle.main, value: "", comment: "")
    }
    
    var charactersArray: [Character] {
        return Array(self)
    }
    
    func dateToHoure() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "HH:mm"
        
        let date = dateFormatter.date(from: self)
        let newHour = dateFormatter.string(from: date ?? Date())
        return newHour
    }
    
    func toDate(withFormat format: String = "yyyy-MM-dd HH:mm:ss") -> Date {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = format
        let date = dateFormatter.date(from: self)

        return date ?? Date()
    }
    
}

extension String {
    var isValidEmail: Bool {
        let emailRegEx = "^[a-z0-9!#$%&'*+/=?^_`{|}~-]+(?:\\.[a-z0-9!#$%&'*+/=?^_`{|}~-]+)*@(?:[a-z0-9](?:[a-z0-9-]*[a-z0-9])?\\.)+[a-z0-9](?:[a-z0-9-]*[a-z0-9])?$"
        let emailTest = NSPredicate(format: "SELF MATCHES %@", emailRegEx)
        return emailTest.evaluate(with: self)
    }
    
    mutating func trim() -> String {
        self = trimmingCharacters(in: CharacterSet.whitespacesAndNewlines)
        return self
    }
    
    var isValidFirstName: (valid: Bool, error: String?) {
        let emptyMessage = "Field required"
        
        guard !self.isEmpty else { return (false, emptyMessage) }
        let nameRegEx = "[a-zA-Z ]{1,}+"
        let nameTest = NSPredicate(format: "SELF MATCHES %@", nameRegEx)
        return (nameTest.evaluate(with: self), "Invalid format")
    }
    
    var isValidLastName: (valid: Bool, error: String?) {
        let emptyMessage = "Field required"
        
        guard !self.isEmpty else { return (false, emptyMessage) }
        let nameRegEx = "[a-zA-Z ]{1,}+"
        let nameTest = NSPredicate(format: "SELF MATCHES %@", nameRegEx)
        return (nameTest.evaluate(with: self), "Invalid format")
    }
    
    var isValidPassword: Bool {
        return self.count >= 8
    }
    
    var isInvalidPassword: Bool {
        return self.count < 8
    }
    
    var isValidContactNumber: Bool {
        let contactNumberRegEx = "^[0-9]{10}$"
        let contactNumberTest = NSPredicate(format: "SELF MATCHES %@", contactNumberRegEx)
        return contactNumberTest.evaluate(with: self)
    }
    
    var isValidVerificationCode: Bool {
        let contactNumberRegEx = "^[0-9]{6}$"
        let contactNumberTest = NSPredicate(format: "SELF MATCHES %@", contactNumberRegEx)
        return contactNumberTest.evaluate(with: self)
    }
    
    func addSpacing(_ font: UIFont?, spacing: CGFloat) -> NSMutableAttributedString{
        let attributedString = NSMutableAttributedString(string: self)
        attributedString.addAttribute(NSAttributedString.Key.kern, value: spacing, range: NSRange(location: 0, length: self.count))
        if let font = font {
            attributedString.addAttribute(NSAttributedString.Key.font, value: font, range: NSRange(location: 0, length: self.count))
        }
        return attributedString
    }
}

