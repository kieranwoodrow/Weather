//
//  WeatherTests.swift
//  WeatherTests
//
//  Created by Kieran Woodrow on 2022/04/21.
//

import XCTest
@testable import Weather

class WeatherTests: XCTestCase {
    
    override func setUp() {
        delegate = MockDelegate()
        repository = MockRepository()
        viewModel = WeatherViewModel(repository: repository, delegate: delegate)
    }
    
    func testWeatherListCountReturnsCorrectNumberOfWeatherResponses() {
        repository.failed = false
        repository.selectedEmptyWeather = false
        viewModel.weatherList()
        XCTAssertEqual(viewModel.weatherListCount, 2)
    }
    
    func testWeatherListCountReturnsZeroIfApiCallFailsToPopulateWeatherList() {
        repository.failed = true
        repository.selectedEmptyWeather = true
        viewModel.weatherList()
        XCTAssertEqual(viewModel.weatherListCount, 0)
    }
    
    func testUpcomingDaysListCountReturnsCorrectNumberOfDays() {
        repository.failed = false
        repository.selectedEmptyWeather = false
        viewModel.weatherList()
        XCTAssertEqual(viewModel.upcomingDaysCount, 5)
    }
    
    func testForcastedWeatherTemperatureReturnsCorrectValue() {
        repository.failed = false
        repository.selectedEmptyWeather = false
        viewModel.weatherList()
        XCTAssertEqual(viewModel.forcastedTemp(atIndex: 0), Int(12.82))
    }
    
    func testForcastedWeatherTemperatureReturnsZeroIfNil() {
        repository.failed = false
        repository.selectedEmptyWeather = true
        viewModel.weatherList()
        XCTAssertEqual(viewModel.forcastedTemp(atIndex: 0), 0)
    }
    
    func testCurrentWeatherTemperatureReturnsCorrectValue() {
        repository.failed = false
        repository.selectedEmptyWeather = false
        viewModel.weather()
        XCTAssertEqual(viewModel.currentTemp, Int(18.89))
    }
    
    func testCurrentWeatherTemperatureReturnsZeroIfNil() {
        repository.failed = false
        repository.selectedEmptyWeather = true
        viewModel.weather()
        XCTAssertEqual(viewModel.currentTemp, Int(0.0))
    }
    
    func testMinWeatherTemperatureReturnsCorrectValue() {
        repository.failed = false
        repository.selectedEmptyWeather = false
        viewModel.weather()
        XCTAssertEqual(viewModel.minTemp, Int(15.88))
    }
    
    func testMinWeatherTemperatureReturnsZeroIfNil() {
        repository.failed = false
        repository.selectedEmptyWeather = true
        viewModel.weather()
        XCTAssertEqual(viewModel.minTemp, Int(0.0))
    }
    
    func testMaxWeatherTemperatureReturnsCorrectValue() {
        repository.failed = false
        repository.selectedEmptyWeather = false
        viewModel.weather()
        XCTAssertEqual(viewModel.maxTemp, Int(19.11))
    }
    
    func testMaxWeatherTemperatureReturnsZeroIfNil() {
        repository.failed = false
        repository.selectedEmptyWeather = true
        viewModel.weather()
        XCTAssertEqual(viewModel.maxTemp, Int(0.0))
    }
    
    func testWeatherConditionReturnsCorrectCondition() {
        repository.failed = false
        repository.selectedEmptyWeather = false
        viewModel.weather()
        XCTAssertEqual(viewModel.condition, "Cloudy")
    }
    
    func testWeatherConditionReturnsEmptyPlaceholderIfNil() {
        repository.failed = false
        repository.selectedEmptyWeather = true
        viewModel.weather()
        XCTAssertEqual(viewModel.condition, "--")
    }
   
    func testWeatherListSuccess() {
        repository.failed = false
        viewModel.weatherList()
        XCTAssert(delegate.reloadViewCalled)
        XCTAssertFalse(delegate.showErrorCalled)
    }
    
    func testWeatherListSuccessFailure() {
        repository.failed = true
        viewModel.weatherList()
        XCTAssert(delegate.showErrorCalled)
        XCTAssertFalse(delegate.reloadViewCalled)
    }
    
    func testWeatherSuccess() {
        repository.failed = false
        viewModel.weather()
        XCTAssert(delegate.reloadViewCalled)
        XCTAssertFalse(delegate.showErrorCalled)
    }
    
    func testWeatherFailure() {
        repository.failed = true
        viewModel.weather()
        XCTAssert(delegate.showErrorCalled)
        XCTAssertFalse(delegate.reloadViewCalled)
    }
    
    private var viewModel: WeatherViewModel!
    private var delegate: MockDelegate!
    private var repository: MockRepository!
    
    class MockRepository: WeatherRepositoryType {
        
        var failed = false
        var selectedEmptyWeather = false
        
        func fetchForcastedWeather(lat: String, long: String, completion: @escaping (ForcastedWeather)) {
            if failed {
                completion(.failure(.unsuccessfullWeatherApiCall))
            } else {
                completion(.success(mockForcastedWeatherList(selectedEmptyWeatherList: selectedEmptyWeather)))
            }
        }
        
        func fetchCurrentWeather(lat: String, long: String, completion: @escaping (CurrentWeather)) {
            if failed {
                completion(.failure(.unsuccessfullWeatherApiCall))
            } else {
                completion(.success(mockCurrentWeatherData(selectedEmptyWeather: selectedEmptyWeather)))
            }
        }
        
        private func mockForcastedWeatherList(selectedEmptyWeatherList: Bool) -> WeatherList {
            let emptyWeather = selectedEmptyWeather
            let emptyWeatherResponse1 = WeatherResponse(weather: nil, temperature: nil)
            let emptyWeatherResponse2 = WeatherResponse(weather: nil, temperature: nil)
            let populatedWeather1 = Weather(weatherDescription: "Cloudy")
            let populatedTemperature1 = Temperature(currentTemp: 12.82, minTemp: 14.45, maxTemp: 19.18)
            let populatedWeatherResponse1 = WeatherResponse(weather: [populatedWeather1], temperature: populatedTemperature1)
            let populatedWeather2 = Weather(weatherDescription: "Sunny")
            let populatedTemperature2 = Temperature(currentTemp: 11.54, minTemp: 14.76, maxTemp: 17.10)
            let populatedWeatherResponse2 = WeatherResponse(weather: [populatedWeather2], temperature: populatedTemperature2)
            let emptyWeatherResponseArray = [emptyWeatherResponse1, emptyWeatherResponse2]
            let populatedWeatherResponseArray = [populatedWeatherResponse1, populatedWeatherResponse2]
            
            if emptyWeather {
                return WeatherList(weatherList: emptyWeatherResponseArray)
            } else {
                return WeatherList(weatherList: populatedWeatherResponseArray)
            }
        }
        
        private func mockCurrentWeatherData(selectedEmptyWeather: Bool) -> WeatherResponse {
            let emptyWeather = selectedEmptyWeather
            let emptyWeatherResponse = WeatherResponse(weather: nil, temperature: nil)
            let populatedWeather = Weather(weatherDescription: "Cloudy")
            let populatedTemperature = Temperature(currentTemp: 18.89, minTemp: 15.88, maxTemp: 19.11)
            let populatedWeatherResponse = WeatherResponse(weather: [populatedWeather], temperature: populatedTemperature)
            
            if emptyWeather {
                return emptyWeatherResponse
            } else {
                return populatedWeatherResponse
            }
        }
    }
    
    class MockDelegate: ViewModelDelegate {
        var showErrorCalled = false
        var reloadViewCalled = false
        
        func reloadView() {
            reloadViewCalled = true
        }
        
        func show(error: CustomError) {
            showErrorCalled = true
        }
    }
}
