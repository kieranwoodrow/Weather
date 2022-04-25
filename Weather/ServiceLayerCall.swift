//
//  ServiceLayerCall.swift
//  Weather
//
//  Created by Kieran Woodrow on 2022/04/22.
//

import Foundation

func serviceCall<Generic: Codable>(with request: URLRequest, model: Generic.Type,
                                   completion: @escaping((Result<Generic, CustomError>) -> Void)) {
    
    let dataTask = URLSession.shared.dataTask(with: request) { data, _, error in
        guard error == nil else {
            completion(.failure(.invalidUrl))
            return
        }
        do {
            guard let safeData = data else {
                completion(.failure(.invalidData))
                return
            }
            print("Valid data")
            let decodedObject = try JSONDecoder().decode(model, from: safeData)
            DispatchQueue.main.async {
                completion(Result.success(decodedObject))
            }
        } catch {
            completion(Result.failure(.parsingError))
        }
    }
    dataTask.resume()
}
