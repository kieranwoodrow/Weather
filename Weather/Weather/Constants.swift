//
//  Constants.swift
//  Weather
//
//  Created by Kieran Woodrow on 2022/04/23.
//

import Foundation

struct Constants {
    static let apiKey = Bundle.main.infoDictionary?["API_KEY"] as? String
    static let currrentWeather = "https://api.openweathermap.org/data/2.5/weather"
    static let focastedWeather = "https://api.openweathermap.org/data/2.5/forecast"
}
