//
//  Weather.swift
//  Weather
//
//  Created by Kieran Woodrow on 2022/04/23.
//

import Foundation

struct Weather: Codable {
    let weatherCondition: [WeatherCondition?]
    let temperature: Temperature?

    private enum CodingKeys: String, CodingKey {
        case weatherCondition = "weatherCondition"
        case temperature = "main"
    }
}

struct Temperature: Codable {
    let currentTemperature: Double?
    let minTemperature: Double?
    let maxTemperature: Double?
    
    private enum CodingKeys: String, CodingKey {
          case currentTemperature = "temp"
          case minTemperature = "temp_min"
          case maxTemperature = "temp_max"
      }
}

struct WeatherCondition: Codable {
    let condition: String?
    
    private enum CodingKeys: String, CodingKey {
          case condition = "main"
      }
}
