//
//  WeatherRepository.swift
//  Weather
//
//  Created by Kieran Woodrow on 2022/04/24.
//

import Foundation

typealias ForcastedWeather = (Result<WeatherList, CustomError>) -> Void
typealias CurrentWeather = (Result<WeatherResponse, CustomError>) -> Void

protocol WeatherRepositoryType: AnyObject {
    func fetchForcastedWeather(lat: String, long: String, completion: @escaping(ForcastedWeather))
    func fetchCurrentWeather(lat: String, long: String, completion: @escaping (CurrentWeather))
}

class WeatherRepository: WeatherRepositoryType {
    func fetchForcastedWeather(lat: String, long: String, completion: @escaping (ForcastedWeather)) {
        let url = Endpoint().forcast(lat: lat, long: long)
        request(endpoint: url,
                method: HTTPMethod.GET,
                completion: completion)
    }
    
    func fetchCurrentWeather(lat: String, long: String, completion: @escaping (CurrentWeather)) {
        let url = Endpoint().current(lat: lat, long: long)
        request(endpoint: url,
                method: HTTPMethod.GET,
                completion: completion)
    }
    
    private func request<T: Codable>(endpoint: String,
                                     method: HTTPMethod,
                                     completion: @escaping((Result<T, CustomError>) -> Void)) {
        guard let safeUrl = URL(string: endpoint) else {
            completion(.failure(.internalError))
            return
        }
        
        var request = URLRequest(url: safeUrl)
        request.httpMethod = "\(method)"
        request.allHTTPHeaderFields = ["Content-Type": "application/json"]
        serviceCall(with: request, model: T.self, completion: completion)
    }
}
