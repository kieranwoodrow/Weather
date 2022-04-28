//
//  Constants.swift
//  Weather
//
//  Created by Kieran Woodrow on 2022/04/23.
//

import Foundation

struct Constants {
    static let currrentWeather = "https://api.openweathermap.org/data/2.5/weather"
    static let focastedWeather = "https://api.openweathermap.org/data/2.5/forecast"
    static let apiKey = Apikey().apiKey
    static let themes = ["forrest", "sea"]
    static let sunnyCondition = ["clear"]
    static let cloudyCondition = ["drizzle"]
    static let rainyCondition = ["thunderstorm", "drizzle", "rain", "snow","tornado",
                                 "mist", "smoke", "haze", "dust","fog", "sand", "ash", "squall"]
}
