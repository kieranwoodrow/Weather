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
    
    private var currentWeather: WeatherResponse?
    private var forcastedWeather: WeatherList?
    private weak var delegate: ViewModelDelegate?
    private var repository: WeatherRepositoryType?
    private var upcomingDays: [String] = []
    private var date = Date()
    
    init(repository: WeatherRepositoryType,
         delegate: ViewModelDelegate) {
        self.repository = repository
        self.delegate = delegate
        self.nextFiveDays()
    }
    
    func nextFiveDays() {
        upcomingDays = date.nextFiveDays(date: date.self)
    }
    
    func day(atIndex: Int) -> String {
        return upcomingDays[atIndex]
    }
    
    var upcomingDaysCount: Int {
        return upcomingDays.count
    }
    
    var weatherListCount: Int {
        return forcastedWeather?.weatherList?.count ?? 0
    }
    
    func forcastedTemp(atIndex: Int) -> Int {
        return Int(forcastedWeather?.weatherList?[atIndex].temperature?.currentTemp ?? 0.0)
    }
    
    func forcastedCondition(atIndex: Int) -> String {
        return forcastedWeather?.weatherList?[0].weather?[0].weatherDescription ?? "--"
    }
    
    var currentTemp: Int {
        return Int(currentWeather?.temperature?.currentTemp ?? 0.0)
    }
    
    var minTemp: Int {
        return Int(currentWeather?.temperature?.minTemp ?? 0.0)
    }
    
    var maxTemp: Int {
        return Int(currentWeather?.temperature?.maxTemp ?? 0.0)
    }
    
    var condition: String {
        return currentWeather?.weather?[0].weatherDescription ?? "--"
    }
    
    func weather() {
        repository?.fetchCurrentWeather(lat: "-26.02", long: "28.00", completion: { [weak self] result in
            switch result {
            case .success(let weather):
                self?.currentWeather = weather
                self?.delegate?.reloadView()
            case .failure(let error):
                self?.delegate?.show(error: error)
            }
        })
    }
    
    func weatherList() {
        repository?.fetchForcastedWeather(lat: "-26.02", long: "28.00", completion: { [weak self] result in
            switch result {
            case .success(let weatherList):
                self?.forcastedWeather = weatherList
                self?.delegate?.reloadView()
            case .failure(let error):
                self?.delegate?.show(error: error)
            }
        })
    }
}
