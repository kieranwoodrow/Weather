//
//  WeatherViewModel.swift
//  Weather
//
//  Created by Kieran Woodrow on 2022/04/24.
//

import Foundation

protocol ViewModelDelegate: AnyObject {
    func reloadView()
    func show(error: CustomError)
}

class WeatherViewModel {
    
    private var repository: WeatherRepositoryType?
    private var weather: WeatherList?
    private weak var delegate: ViewModelDelegate?
    
    init(repository: WeatherRepositoryType,
         delegate: ViewModelDelegate) {
        self.repository = repository
        self.delegate = delegate
    }
    
    var currentTemp: Double {
        return weather?.weatherList?[0].temperature?.currentTemp ?? 0.0
    }
    
    var minTemp: Double {
        return weather?.weatherList?[0].temperature?.minTemp ?? 0.0
    }
    
    var maxTemp: Double {
        return weather?.weatherList?[0].temperature?.maxTemp ?? 0.0
    }
    
    var condition: String {
        return weather?.weatherList?[0].weather?[0].weatherDescription ?? "none"
    }
    
    func getWeather() {
        repository?.fetchWeather(lat: "-26.02", long: "28.00", completion: { [weak self] result in
            switch result {
            case .success(let weatherResponse):
                self?.weather = weatherResponse
                print(weatherResponse)
                self?.delegate?.reloadView()
            case .failure(let error):
                print(error)
                self?.delegate?.show(error: error)
            }
        })
    }
}
