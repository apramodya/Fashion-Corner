//
//  Extensions.swift
//  Fashion Corner
//
//  Created by Pramodya Abeysinghe on 11/6/19.
//  Copyright © 2019 Pramodya. All rights reserved.
//

import UIKit
import Firebase

extension String {
    var isNotEmpty: Bool {
        return !isEmpty
    }
}

extension Int {
    func centsToFormattedCurrency() -> String {
        let unit = Double(self) / 100
        let formatter = NumberFormatter()
        formatter.numberStyle = .currency
        formatter.locale = Locale(identifier: "si_LK")
        
        if let unitString = formatter.string(from: unit as NSNumber) {
            return unitString
        }
        
        return formatter.string(from: 0 as NSNumber)!
    }
}


extension UIViewController {
    
    func simpleAlert(title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        present(alert, animated: true, completion: nil)
    }
}

extension UITableViewCell {
    override open func layoutSubviews() {
        super.layoutSubviews()
        
        contentView.frame = contentView.frame.inset(by: UIEdgeInsets(top: 1, left: 0, bottom: 5, right: 0))
    }
}

extension Auth {
    func handleFireAuthError(error: Error, vc: UIViewController) {
        if let errorCode = AuthErrorCode(rawValue: error._code) {
            let alert = UIAlertController(title: "Error", message: errorCode.errorMessage, preferredStyle: .alert)
            let okAction = UIAlertAction(title: "OK", style: .default, handler: nil)
            
            alert.addAction(okAction)
            vc.present(alert, animated: true, completion: nil)
        }
    }
}

extension AuthErrorCode {
    var errorMessage: String {
        switch self {
        case .emailAlreadyInUse:
            return "The email is already in use with another account. Pick another email!"
        case .userNotFound:
            return "Account not found for the specified user. Please check and try again"
        case .userDisabled:
            return "Your account has been disabled. Please contact support."
        case .invalidEmail, .invalidSender, .invalidRecipientEmail:
            return "Please enter a valid email"
        case .networkError:
            return "Network error. Please try again."
        case .weakPassword:
            return "Your password is too weak. The password must be 6 characters long or more."
        case .wrongPassword:
            return "Your password or email is incorrect."
            
        default:
            return "Sorry, something went wrong."
        }
    }
}
