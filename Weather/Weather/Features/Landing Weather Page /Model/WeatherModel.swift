//
//  WeatherModel.swift
//  Weather
//
//  Created by Kieran Woodrow on 2022/04/24.
//

import Foundation

struct WeatherList: Codable {
    let weatherList: [WeatherResponse]?
    
    enum CodingKeys: String, CodingKey {
        case weatherList = "list"
    }
}

struct WeatherResponse: Codable {
    let weather: [Weather]?
    let temperature: Temperature?
    
    enum CodingKeys: String, CodingKey {
        case weather
        case temperature = "main"
    }
}

struct Temperature: Codable {
    let currentTemp, minTemp, maxTemp: Double?
    
    enum CodingKeys: String, CodingKey {
        case currentTemp = "temp"
        case minTemp = "temp_min"
        case maxTemp = "temp_max"
    }
}

struct Weather: Codable {
    let  weatherDescription: String?
    
    enum CodingKeys: String, CodingKey {
        case weatherDescription = "description"
    }
}
