//
//  WeatherTests.swift
//  WeatherTests
//
//  Created by Kieran Woodrow on 2022/04/21.
//

import XCTest
import CoreData
import CoreLocation
@testable import Weather

class WeatherTests: XCTestCase {
    
    override func setUp() {
        delegate = MockDelegate()
        repository = MockRepository()
        viewModel = WeatherViewModel(repository: repository, delegate: delegate)
        savedLocationsMockRepository = SavedLocationMockRepository()
        saveLocationViewModel = SavedLocationViewModel(repository: savedLocationsMockRepository, delegate: delegate)
    }
    
    func testForrestBackgroundImageReturnsCorrectImageBasedOnCloudyForrestTheme() {
        repository.failed = false
        repository.selectedEmptyWeather = false
        viewModel.weatherList()
        XCTAssertEqual(viewModel.backgroundImage(theme: "forrest", condition: "clouds"), "CloudyForrest")
    }
    
    func testSavedLocationsArrayReturnsCorrectZeroWhenNil() {
        savedLocationsMockRepository.failed = false
        savedLocationsMockRepository.selectedEmptyLocation = true
        XCTAssertEqual(saveLocationViewModel.locationsCount, 0)
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
    
    func testApiKey() {
        XCTAssertEqual(Constants.apiKey, Constants.apiKey)
    }
    
    func testCurrentEndpointWithApiKey() {
        let endpoint = Endpoint()
        XCTAssertEqual(endpoint.current(lat: "10", long: "10"),
                       Constants.currrentWeather + "?lat=10&lon=10&appid=\(Constants.apiKey)&units=metric")
    }
    
    func testForcastedEndpointWithApiKey() {
        let endpoint = Endpoint()
        XCTAssertEqual(endpoint.forcast(lat: "10", long: "10"),
                       Constants.focastedWeather + "?lat=10&lon=10&appid=\(Constants.apiKey)&units=metric&cnt=5")
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
    
    func testTodayDateFunctionReturnsCorrectWeekdayName() {
        let date = Date()
        XCTAssertEqual(date.today(date: date), "Friday")
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
        XCTAssertEqual(Constants.cloudyCondition, ["clouds", "smoke", "haze", "mist", "sand", "ash", "fog", "dust"])
    }
    
    func testConstantsEndpointRainyCondition() {
        XCTAssertEqual(Constants.rainyCondition, ["rain", "snow", "tornado", "thunderstorm", "squall"])
    }
    
    func testConstantsEndpointCurrrentWeather() {
        XCTAssertEqual(Constants.currrentWeather, "https://api.openweathermap.org/data/2.5/weather")
    }
    
    func testConstantsEndpointFocastedWeather() {
        XCTAssertEqual(Constants.focastedWeather, "https://api.openweathermap.org/data/2.5/forecast")
    }
    
    func testCustomEnumsInvalidUrlFailureReason() {
        XCTAssertEqual(CustomError.invalidUrl.failureReason, "The URL is invalid")
    }
    
    func testCustomEnumsInvalidDataFailureReason() {
        XCTAssertEqual(CustomError.invalidData.failureReason, "The data is invalid")
    }
    func testCustomEnumsInternalErrorFailureReason() {
        XCTAssertEqual(CustomError.internalError.failureReason, "There was an internal error from the API")
    }
    func testCustomEnumsParsingErrorFailureReason() {
        XCTAssertEqual(CustomError.parsingError.failureReason, "There was an error decoding the data from the API")
    }
    func testCustomEnumsUnsuccessfullWeatherApiCallFailureReason() {
        XCTAssertEqual(CustomError.unsuccessfullWeatherApiCall.failureReason, "There was an error retrieving the weather data")
    }
    func testCustomEnumsCoreLocationNotFoundFailureReason() {
        XCTAssertEqual(CustomError.coreLocationNotFound.failureReason, "There was an error retrieving the gps coordinates")
    }
    func testCustomEnumsCoreLocationDeniedFailureReason() {
        XCTAssertEqual(CustomError.coreLocationDenied.failureReason, "Location needs to be enabed" )
    }
    func testCustomEnumsCoreDataUnsuccessfulSaveFailureReason() {
        XCTAssertEqual(CustomError.coreDataUnsuccessfulSave.failureReason, "Could not save to database" )
    }
    
    func testCustomEnumsCoreDataSuccessfulSaveFailureReason() {
        XCTAssertEqual(CustomError.coreDataSuccessfulSave.failureReason, "Successfull save")
    }
    
    func testCustomEnumsInvalidUrlErrorDescription() {
        XCTAssertEqual(CustomError.invalidUrl.errorDescription, "Invalid URL")
    }
    
    func testCustomEnumsInvaliDataErrorDescription() {
        XCTAssertEqual(CustomError.invalidData.errorDescription, "Invalid data")
    }
    func testCustomEnumsInternalErrorDescription() {
        XCTAssertEqual(CustomError.internalError.errorDescription, "Internal error")
    }
    func testCustomEnumsParsingErrorDescription() {
        XCTAssertEqual(CustomError.parsingError.errorDescription, "Passing error")
    }
    func testCustomEnumsUnsuccessfullWeatherApiCallErrorDescription() {
        XCTAssertEqual(CustomError.unsuccessfullWeatherApiCall.errorDescription, "Api call was unsuccessful")
    }
    func testCustomEnumsCoreLocationNotFoundErrorDescription() {
        XCTAssertEqual(CustomError.coreLocationNotFound.errorDescription,
                       "Coordinates cannot be found. Please make sure location services are on and you have signal")
    }
    func testCustomEnumsCoreLocationDeniedErrorDescription() {
        XCTAssertEqual(CustomError.coreLocationDenied.errorDescription, "We will not be able to track the weather in your area" )
    }
    func testCustomEnumsCoreDataUnsuccessfulSaveErrorDescription() {
        XCTAssertEqual(CustomError.coreDataUnsuccessfulSave.errorDescription,
                       "Could not save to database. Coordinates are nil or something else went wrong on our side" )
    }
    
    func testCustomEnumsCoreDataSuccessfulSaveErrorDescription() {
        XCTAssertEqual(CustomError.coreDataSuccessfulSave.errorDescription, "Successfully saved location to database")
    }
    
    func testCurrentLocationReturnsNil() {
        let locationManager = CLLocationManager()
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()
        locationManager.requestWhenInUseAuthorization()
        let currentLocationLattiude = locationManager.location?.coordinate.latitude
        let currentLoationLongitude = locationManager.location?.coordinate.longitude
        XCTAssertNil(currentLocationLattiude)
        XCTAssertNil(currentLoationLongitude)
    }
    
    private var viewModel: WeatherViewModel!
    private var saveLocationViewModel: SavedLocationViewModel!
    private var savedLocationsMockRepository: SavedLocationMockRepository!
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
    }
    
    class SavedLocationMockRepository: SavedLocationRepositoryType {
        func fetchAllSavedLocations(completion: @escaping (LocationResult)) {
            if failed {
                completion(.failure(.invalidData))
            } else {
                completion(.success(mockLocationData(selectedEmptyLocation: selectedEmptyLocation)))
            }
        }
        
        var failed = false
        let coredataObject = (UIApplication.shared.delegate as?
                                               AppDelegate)?.persistentContainer.viewContext
        var selectedEmptyLocation = false
        
        private func mockLocationData(selectedEmptyLocation: Bool) -> [Location] {
            let emptyLocation = selectedEmptyLocation
            let location = Location(context: coredataObject.unsafelyUnwrapped)
            location.latitude = "29.00"
            location.longitude = "23.00"
            let locationArray = [location]
            
            let emptyLocations: [Location] = []
            
            if emptyLocation {
                return emptyLocations
            } else {
                return locationArray
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
