//
//  Endpoint.swift
//  Weather
//
//  Created by Kieran Woodrow on 2022/04/24.
//

import Foundation

struct Endpoint {
    func get(lat: String, long: String) -> String {
        return Constants.focastedWeather + "?lat=\(lat)&lon=\(long)&appid=\(Constants.apiKey)&units=metric&cnt=5"
    }
}
