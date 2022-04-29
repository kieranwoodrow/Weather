//
//  OfflineMode.swift
//  Weather
//
//  Created by Kieran Woodrow on 2022/04/29.
//

import Foundation

typealias CreateOfflineWeather = (Result<Void, CustomError>) -> Void
typealias FetchOfflineWeather = (Result<[CurrentOfflineData], CustomError>) -> Void

protocol OfflineRepositoryType {
    
    func createCurrentOfflineWeather(weatherResponse: WeatherResponse?, completion: @escaping (CreateOfflineWeather))
    func fetchCurrentOfflineWeather(completion: @escaping (FetchOfflineWeather))
}

class OfflineRepository: OfflineRepositoryType {
    private var savedCurrentWeatherResponse: [CurrentOfflineData]? = []
    
    func createCurrentOfflineWeather(weatherResponse: WeatherResponse?, completion: @escaping (CreateOfflineWeather)) {
        
        guard let savedCurrentWeatherResponse = weatherResponse else {
            completion(.failure(.invalidData))
            return
        }
        
        guard let safeCoreData = Constants.coreDataPersistantObject else { return }
        
        guard let condition = savedCurrentWeatherResponse.weather?[0].weatherDescription else { return }
        guard let currentTemp = savedCurrentWeatherResponse.temperature?.currentTemp else { return }
        guard let minTemp = savedCurrentWeatherResponse.temperature?.minTemp else { return }
        guard let maxTemp = savedCurrentWeatherResponse.temperature?.maxTemp else { return }
        
        let dateWhenFetched = Date()
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "HH:mm"
        let saveOfflineWeather = CurrentOfflineData(context: safeCoreData)
        saveOfflineWeather.currentTemp = String(currentTemp)
        saveOfflineWeather.minTemp = String(minTemp)
        saveOfflineWeather.maxTemp = String(maxTemp)
        saveOfflineWeather.condition = condition
        saveOfflineWeather.timeWhenSaved = dateFormatter.string(from: dateWhenFetched)
        
        do {
            try safeCoreData.save()
            completion(.success(()))
        } catch {
            completion(.failure(.coreDataUnsuccessfulSave))
        }
    }
    
    func fetchCurrentOfflineWeather(completion: @escaping (FetchOfflineWeather)) {
        do {
            self.savedCurrentWeatherResponse = try Constants.coreDataPersistantObject?.fetch(CurrentOfflineData.fetchRequest())
            guard let offlineWeatherResponse = self.savedCurrentWeatherResponse else { return }
            completion(.success(offlineWeatherResponse))
        } catch {
            completion(.failure(.parsingError))
        }
    }
}
