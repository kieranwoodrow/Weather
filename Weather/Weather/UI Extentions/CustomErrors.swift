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
    case unsuccessfullWeatherApiCall
    
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
        case .unsuccessfullWeatherApiCall:
            return "Api call was unsuccessful"
        }
    }
    
    var failureReason: String {
        switch self {
        case .invalidUrl:
            return "The URL is invalid"
        case .invalidData:
            return "The data is invalid"
        case .internalError:
            return "There was an internal error from the API"
        case .parsingError:
            return "There was an error decoding the data from the API "
        case .unsuccessfullWeatherApiCall:
            return "There was an error retrieving the weather data "
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
