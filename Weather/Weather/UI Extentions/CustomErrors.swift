//
//  CustomErrors.swift
//  Weather
//
//  Created by Kieran Woodrow on 2022/04/21.
//

import Foundation
import UIKit

enum CustomError: Error, LocalizedError {
    case invalidUrl
    case invalidData
    case internalError
    case parsingError
    
    var errorDescription: String {
        switch self {
        case .invalidUrl:
            return "Invalid URL"
        case .invalidData:
            return "Invalid data"
        case .internalError:
            return "Internal error"
        case .parsingError:
            return "Passing error"
        }
    }
    
    var failureReason: String {
        switch self {
        case .invalidUrl:
            return "The URL is invalid"
        case .invalidData:
            return "The data is invalid"
        case .internalError:
            return "There was an internal error"
        case .parsingError:
            return "There was a parsing error"
        }
    }
}

extension UIViewController {
    func displayErrorAlert(title: CustomError, errorMessage: CustomError, buttonTitle: String) {
        let alert = UIAlertController(title: title.errorDescription,
                                      message: errorMessage.failureReason,
                                      preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: buttonTitle,
                                      style: UIAlertAction.Style.default,
                                      handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
}
