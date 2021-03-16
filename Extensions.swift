//
//  Extensions.swift
//  Refresh
//
//  Created by Avi Khemani on 3/1/21.
//

import Foundation
import UIKit

extension UIViewController {
    
    func displayMessage(title: String, message: String) {
        let alert = UIAlertController(
            title: title,
            message: message,
            preferredStyle: .alert)
        alert.addAction(UIAlertAction(
            title: "Ok",
            style: .default))
        self.present(alert, animated: true)
    }
    
    func displayError() {
        self.displayMessage(title: "Something Went Wrong", message: "Habitat unexpectedly experienced an error. Please try again later.")
    }
    
}

extension Date {
    
    func toMonthDate() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "EEE, MMM d"
        return dateFormatter.string(from: self)
    }
    
    func toLongMonthDate() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "EEEE, MMM d"
        return dateFormatter.string(from: self)
    }
    
    func toShortDate() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MMM d"
        return dateFormatter.string(from: self)
    }
    
    
    func toHourString() -> String {
        let formatter = DateFormatter()
        formatter.locale = Locale(identifier: "en_US_POSIX")
        formatter.dateFormat = "h:mm a"
        formatter.amSymbol = "AM"
        formatter.pmSymbol = "PM"
        return formatter.string(from: self)
    }
}

