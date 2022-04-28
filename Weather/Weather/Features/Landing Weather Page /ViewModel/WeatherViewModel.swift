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
    private var upcomingDays: [String]
    private var date = Date()
    private var lat: String
    private var long: String
    private var saveStatus: Bool
    
    init(repository: WeatherRepositoryType,
         delegate: ViewModelDelegate) {
        self.upcomingDays = []
        self.repository = repository
        self.delegate = delegate
        self.lat = ""
        self.long = ""
        self.saveStatus = false
        self.nextFiveDays()
    }
    
    func set(lat: String, long: String) {
        if !lat.isEmpty, !long.isEmpty {
            self.lat = lat
            self.long = long
        }
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
    
    func backgroundImage(theme: String, condition: String) -> String {
        var backgroundImage = ""
        
        if theme == Constants.themes[0] {
            switch condition {
            case condition where Constants.rainyCondition.contains(where: condition.contains):
                backgroundImage = "RainyForrest"
            case condition where Constants.sunnyCondition.contains(where: condition.contains):
                backgroundImage = "SunnyForrest"
            case condition where Constants.cloudyCondition.contains(where: condition.contains):
                backgroundImage = "CloudyForrest"
            default:
                backgroundImage = "SunnyForrest"
            }
        } else {
            switch condition {
            case condition where Constants.rainyCondition.contains(where: condition.contains):
                backgroundImage = "RainySea"
            case condition where Constants.sunnyCondition.contains(where: condition.contains):
                backgroundImage = "SunnySea"
            case condition where Constants.cloudyCondition.contains(where: condition.contains):
                backgroundImage = "CloudySea"
            default:
                backgroundImage = "SunnySea"
            }
        }
        
        return backgroundImage
    }
    
    func backgroundColour(theme: String, condition: String) -> String {
        var backgroundColour = ""
        
        if theme == Constants.themes[0] {
            switch condition {
            case condition where Constants.rainyCondition.contains(where: condition.contains):
                backgroundColour = "Rainy"
            case condition where Constants.sunnyCondition.contains(where: condition.contains):
                backgroundColour = "Sunny"
            case condition where Constants.cloudyCondition.contains(where: condition.contains):
                backgroundColour = "Cloudy"
            default:
                backgroundColour = "Sunny"
            }
        } else {
            switch condition {
            case condition where Constants.rainyCondition.contains(where: condition.contains):
                backgroundColour = "Rainy"
            case condition where Constants.sunnyCondition.contains(where: condition.contains):
                backgroundColour = "Ocean"
            case condition where Constants.cloudyCondition.contains(where: condition.contains):
                backgroundColour = "Cloudy"
            default:
                backgroundColour = "Ocean"
            }
        }
        return backgroundColour
    }
    
    func toggleThemes(theme: String, condition: String) -> [String] {
        var themeImage = ""
        var themeColour = ""
        if theme == Constants.themes[0] {
            themeImage = backgroundImage(theme: theme, condition: condition)
            themeColour = backgroundColour(theme: theme, condition: condition)
        } else {
            themeImage = backgroundImage(theme: theme, condition: condition)
            themeColour = backgroundColour(theme: theme, condition: condition)
        }
        return [themeImage, themeColour]
    }
    
    func weather() {
        repository?.fetchCurrentWeather(lat: lat, long: long, completion: { [weak self] result in
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
        repository?.fetchForcastedWeather(lat: lat, long: long, completion: { [weak self] result in
            switch result {
            case .success(let weatherList):
                self?.forcastedWeather = weatherList
                self?.delegate?.reloadView()
            case .failure(let error):
                self?.delegate?.show(error: error)
            }
        })
    }
    
    func saveLocationToDatabase() -> Bool {
        
        if !lat.isEmpty, !long.isEmpty {
            repository?.saveLocation(latitude: lat, longitude: long,
                                     completion: { [weak self] result in
                switch result {
                case .success(let savedSuccessfully):
                    self?.saveStatus = savedSuccessfully
                case .failure(let error):
                    self?.delegate?.show(error: error)
                }
            })
        }
        
        return saveStatus
    }
    
    func handleSaveRequest() {
        
        if saveLocationToDatabase() {
            delegate?.show(error: .coreDataSuccessfulSave)
        } else {
            delegate?.show(error: .coreDataUnsuccessfulSave)
        }
    }
}
