//
//  Endpoint.swift
//  Weather
//
//  Created by Kieran Woodrow on 2022/04/24.
//

import Foundation

struct Endpoint {
    func forcast(lat: String, long: String) -> String {
        return Constants.focastedWeather + "?lat=\(lat)&lon=\(long)&appid=\(Constants.apiKey)&units=metric&cnt=5"
    }
    
    func current(lat: String, long: String) -> String {
        return Constants.currrentWeather + "?lat=\(lat)&lon=\(long)&appid=\(Constants.apiKey)&units=metric"
    }
}
