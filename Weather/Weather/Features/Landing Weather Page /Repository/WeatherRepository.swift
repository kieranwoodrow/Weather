//
//  WeatherRepository.swift
//  Weather
//
//  Created by Kieran Woodrow on 2022/04/24.
//

import Foundation

typealias WeatherResult = (Result<WeatherList, CustomError>) -> Void

protocol WeatherRepositoryType: AnyObject {
    func fetchWeather(lat: String, long: String, completion: @escaping(WeatherResult))
}

class WeatherRepository: WeatherRepositoryType {
    func fetchWeather(lat: String, long: String, completion: @escaping (WeatherResult)) {
        let url = Endpoint().get(lat: lat, long: long)
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
