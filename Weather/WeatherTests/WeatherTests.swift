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
    
    func testForrestBackgroundImageReturnsCorrectImageBasedOnCloudyForrestTheme() {
        repository.failed = false
        repository.selectedEmptyWeather = false
        viewModel.weatherList()
        XCTAssertEqual(viewModel.backgroundImage(theme: "forrest", condition: "clouds"), "CloudyForrest")
    }
    
    func testForrestBackgroundImageReturnsCorrectImageBasedOnSunnyForrestTheme() {
        repository.failed = false
        repository.selectedEmptyWeather = false
        viewModel.weatherList()
        XCTAssertEqual(viewModel.backgroundImage(theme: "forrest", condition: "sunny"), "SunnyForrest")
    }
    
    func testForrestBackgroundImageReturnsCorrectImageBasedOnRainyForrestTheme() {
        repository.failed = false
        repository.selectedEmptyWeather = false
        viewModel.weatherList()
        XCTAssertEqual(viewModel.backgroundImage(theme: "forrest", condition: "thunderstorm"), "RainyForrest")
    }
    
    func testForrestBackgroundImageReturnsCorrectImageBasedOnDefault() {
        repository.failed = false
        repository.selectedEmptyWeather = false
        viewModel.weatherList()
        XCTAssertEqual(viewModel.backgroundImage(theme: "forrest", condition: "--"), "SunnyForrest")
    }
    
    func testSeaBackgroundImageReturnsCorrectImageBasedOnCloudySeaTheme() {
        repository.failed = false
        repository.selectedEmptyWeather = false
        viewModel.weatherList()
        XCTAssertEqual(viewModel.backgroundImage(theme: "sea", condition: "clouds"), "CloudySea")
    }
    
    func testSeaBackgroundImageReturnsCorrectImageBasedOnSunnySeaTheme() {
        repository.failed = false
        repository.selectedEmptyWeather = false
        viewModel.weatherList()
        XCTAssertEqual(viewModel.backgroundImage(theme: "sea", condition: "sunny"), "SunnySea")
    }
    
    func testSeaBackgroundImageReturnsCorrectImageBasedOnRainySeaTheme() {
        repository.failed = false
        repository.selectedEmptyWeather = false
        viewModel.weatherList()
        XCTAssertEqual(viewModel.backgroundImage(theme: "sea", condition: "thunderstorm"), "RainySea")
    }
    
    func testSeaBackgroundImageReturnsCorrectImageBasedOnDefault() {
        repository.failed = false
        repository.selectedEmptyWeather = false
        viewModel.weatherList()
        XCTAssertEqual(viewModel.backgroundImage(theme: "sea", condition: "--"), "SunnySea")
    }
    
    func testForrestBackgroundColourReturnsCorrectColourBasedOnCloudyForrestTheme() {
        repository.failed = false
        repository.selectedEmptyWeather = false
        viewModel.weatherList()
        XCTAssertEqual(viewModel.backgroundColour(theme: "forrest", condition: "clouds"), "Cloudy")
    }
    
    func testForrestBackgroundColourReturnsCorrectColourBasedOnSunnyForrestTheme() {
        repository.failed = false
        repository.selectedEmptyWeather = false
        viewModel.weatherList()
        XCTAssertEqual(viewModel.backgroundColour(theme: "forrest", condition: "sunny"), "Sunny")
    }
    
    func testForrestBackgroundColourReturnsCorrectColourBasedOnRainyForrestTheme() {
        repository.failed = false
        repository.selectedEmptyWeather = false
        viewModel.weatherList()
        XCTAssertEqual(viewModel.backgroundColour(theme: "forrest", condition: "thunderstorm"), "Rainy")
    }
    
    func testForrestBackgroundColourReturnsCorrectColourBasedOnDefault() {
        repository.failed = false
        repository.selectedEmptyWeather = false
        viewModel.weatherList()
        XCTAssertEqual(viewModel.backgroundColour(theme: "forrest", condition: "--"), "Sunny")
    }
    
    func testSeaBackgroundColourReturnsCorrectColourBasedOnSunnySeaTheme() {
        repository.failed = false
        repository.selectedEmptyWeather = false
        viewModel.weatherList()
        XCTAssertEqual(viewModel.backgroundColour(theme: "sea", condition: "sunny"), "Ocean")
    }
    
    func testSeaBackgroundColourReturnsCorrectColourBasedOnCloudySeaTheme() {
        repository.failed = false
        repository.selectedEmptyWeather = false
        viewModel.weatherList()
        XCTAssertEqual(viewModel.backgroundColour(theme: "sea", condition: "clouds"), "Cloudy")
    }
    
    func testSeaBackgroundColourReturnsCorrectColourBasedOnRainySeaTheme() {
        repository.failed = false
        repository.selectedEmptyWeather = false
        viewModel.weatherList()
        XCTAssertEqual(viewModel.backgroundColour(theme: "sea", condition: "thunderstorm"), "Rainy")
    }
    
    func testSeaBackgroundColourReturnsCorrectColourBasedOnDefault() {
        repository.failed = false
        repository.selectedEmptyWeather = false
        viewModel.weatherList()
        XCTAssertEqual(viewModel.backgroundColour(theme: "sea", condition: "--"), "Ocean")
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
    
    func testForcastedWeatherConditionReturnsCorrectCondition() {
        repository.failed = false
        repository.selectedEmptyWeather = false
        viewModel.weatherList()
        XCTAssertEqual(viewModel.forcastedCondition(atIndex: 0), "Cloudy")
    }
    func testForcastedWeatherConditionsReturnsPlaceholderIfNil() {
        repository.failed = false
        repository.selectedEmptyWeather = true
        viewModel.weatherList()
        XCTAssertEqual(viewModel.forcastedCondition(atIndex: 0), "--")
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
    
    func testForrestBackgroundImageReturnsCorrectImage() {
        repository.failed = false
        repository.selectedEmptyWeather = false
        viewModel.weatherList()
        XCTAssertEqual(viewModel.backgroundImage(theme: "forrest", condition: "clear"), "SunnyForrest")
    }
    
    func testSeaBackgroundImageReturnsCorrectImage() {
        repository.failed = false
        repository.selectedEmptyWeather = false
        viewModel.weatherList()
        XCTAssertEqual(viewModel.backgroundImage(theme: "sea", condition: "clear"), "SunnySea")
    }
    
    func testForrestBackgroundColourReturnsColour() {
        repository.failed = false
        repository.selectedEmptyWeather = false
        viewModel.weatherList()
        XCTAssertEqual(viewModel.backgroundColour(theme: "forrest", condition: "clear"), "Sunny")
    }
    
    func testSeaBackgroundColourReturnsColour() {
        repository.failed = false
        repository.selectedEmptyWeather = false
        viewModel.weatherList()
        XCTAssertEqual(viewModel.backgroundColour(theme: "sea", condition: "clear"), "Ocean")
    }
    
    func testToggleThemesFunctionReturnsCorrectArrayForForrestTheme() {
        repository.failed = false
        repository.selectedEmptyWeather = false
        viewModel.weatherList()
        XCTAssertEqual(viewModel.toggleThemes(theme: "forrest", condition: "clear"), ["SunnyForrest", "Sunny"])
    }
    
    func testToggleThemesFunctionReturnsCorrectArrayForSeaTheme() {
        repository.failed = false
        repository.selectedEmptyWeather = false
        viewModel.weatherList()
        XCTAssertEqual(viewModel.toggleThemes(theme: "sea", condition: "clear"), ["SunnySea", "Ocean"])
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
    
    func testConstantsEndpointTheme() {
        XCTAssertEqual(Constants.themes, ["forrest", "sea"])
    }
    
    func testConstantsEndpointSunnyCondition() {
        XCTAssertEqual(Constants.sunnyCondition, ["clear"])
    }
    
    func testConstantsEndpointCloudyCondition() {
        XCTAssertEqual(Constants.cloudyCondition, ["clouds", "smoke"])
    }
    
    func testConstantsEndpointRainyCondition() {
        XCTAssertEqual(Constants.rainyCondition,  ["fog", "rain", "snow", "tornado", "mist", "haze",
                                                   "dust","thunderstorm", "sand", "ash", "squall"])
    }
    
    func testConstantsEndpointCurrrentWeather() {
        XCTAssertEqual(Constants.currrentWeather, "https://api.openweathermap.org/data/2.5/weather")
    }
    
    func testConstantsEndpointFocastedWeather() {
        XCTAssertEqual(Constants.focastedWeather, "https://api.openweathermap.org/data/2.5/forecast")
    }
    
    func testCustomEnums1() {
        XCTAssertEqual(CustomError.invalidUrl.failureReason, "The URL is invalid")
    }
    
    func testCustomEnums3() {
        XCTAssertEqual(CustomError.invalidData.failureReason, "The data is invalid")
    }
    func testCustomEnums4() {
        XCTAssertEqual(CustomError.internalError.failureReason, "There was an internal error from the API")
    }
    func testCustomEnums5() {
        XCTAssertEqual(CustomError.parsingError.failureReason, "There was an error decoding the data from the API")
    }
    func testCustomEnums6() {
        XCTAssertEqual(CustomError.unsuccessfullWeatherApiCall.failureReason, "There was an error retrieving the weather data")
    }
    func testCustomEnums7() {
        XCTAssertEqual(CustomError.coreLocationNotFound.failureReason, "There was an error retrieving the gps coordinates")
    }
    func testCustomEnums8() {
        XCTAssertEqual(CustomError.coreLocationDenied.failureReason, "Location needs to be enabed" )
    }
    func testCustomEnums9() {
        XCTAssertEqual(CustomError.coreDataUnsuccessfulSave.failureReason, "Could not save to database" )
    }
    
    func testCustomEnums2() {
        XCTAssertEqual(CustomError.coreDataSuccessfulSave.failureReason, "Successfull save")
    }
    
    func testCustomEnums11() {
        XCTAssertEqual(CustomError.invalidUrl.errorDescription, "Invalid URL")
    }
    
    func testCustomEnums13() {
        XCTAssertEqual(CustomError.invalidData.errorDescription, "Invalid data")
    }
    func testCustomEnums14() {
        XCTAssertEqual(CustomError.internalError.errorDescription, "Internal error")
    }
    func testCustomEnums15() {
        XCTAssertEqual(CustomError.parsingError.errorDescription, "Passing error")
    }
    func testCustomEnums16() {
        XCTAssertEqual(CustomError.unsuccessfullWeatherApiCall.errorDescription, "Api call was unsuccessful")
    }
    func testCustomEnums17() {
        XCTAssertEqual(CustomError.coreLocationNotFound.errorDescription,
                       "Coordinates cannot be found. Please make sure location services are on and you have signal")
    }
    func testCustomEnums18() {
        XCTAssertEqual(CustomError.coreLocationDenied.errorDescription, "We will not be able to track the weather in your area" )
    }
    func testCustomEnums19() {
        XCTAssertEqual(CustomError.coreDataUnsuccessfulSave.errorDescription,
                       "Could not save to database. Coordinates are nil or something else went wrong on our side" )
    }
    
    func testCustomEnums20() {
        XCTAssertEqual(CustomError.coreDataSuccessfulSave.errorDescription, "Successfully saved location to database")
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
        
        func saveLocation(latitude: String, longitude: String, completion: @escaping (SaveLocationResult)) {
            
        }
        
        func fetchData() -> [Location] {
            return []
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
