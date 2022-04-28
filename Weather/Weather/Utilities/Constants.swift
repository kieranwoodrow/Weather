//
//  Constants.swift
//  Weather
//
//  Created by Kieran Woodrow on 2022/04/23.
//

import Foundation
import UIKit

struct Constants {
    static let apiKey = Apikey().apiKey
    static let currrentWeather = "https://api.openweathermap.org/data/2.5/weather"
    static let focastedWeather = "https://api.openweathermap.org/data/2.5/forecast"
    static let coreDataPersistantObject = (UIApplication.shared.delegate as?
                                           AppDelegate)?.persistentContainer.viewContext
    static let themes = ["forrest", "sea"]
    static let sunnyCondition = ["clear"]
    static let rainyCondition = ["rain", "snow", "tornado", "thunderstorm", "squall"]
    static let cloudyCondition = ["clouds", "smoke", "haze", "mist", "sand", "ash", "fog", "dust"]
}
