//
//  WeatherViewController.swift
//  Weather
//
//  Created by Kieran Woodrow on 2022/04/21.
//

import UIKit
import Foundation
import CoreLocation

class WeatherViewController: UIViewController {
    
    @IBOutlet weak private var currentTemperatureView: UIView!
    @IBOutlet weak private var bottomView: UIView!
    @IBOutlet weak private var themeImage: UIImageView!
    @IBOutlet weak private var tempValue: UILabel!
    @IBOutlet weak private var tempCondition: UILabel!
    @IBOutlet weak private var minTemp: UILabel!
    @IBOutlet weak private var currentTemp: UILabel!
    @IBOutlet weak private var maxTemp: UILabel!
    @IBOutlet weak private var forcastedTableView: UITableView!
    private let locationManager = CLLocationManager()
    private var lat = ""
    private var long = ""
    private var theme = "forrest"
    private lazy var weatherViewModel = WeatherViewModel(repository: WeatherRepository(),
                                                         delegate: self)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setWeatherViewController()
    }
    
    @IBAction private func forrestButtonPressed(_ sender: Any) {
        
        theme = "forrest"
        toggleThemes(theme: theme, weatherCondition: weatherViewModel.condition.lowercased())
    }
    
    @IBAction private func seaButtonPressed(_ sender: Any) {
        
        theme = "sea"
        toggleThemes(theme: theme, weatherCondition: weatherViewModel.condition.lowercased())
    }
    
    func setCoreLocation() {
        
        locationManager.delegate = self
        currentLocation()
    }
    
    private func setTableView() {
        
        forcastedTableView.delegate = self
        forcastedTableView.dataSource = self
    }
    
    private func setWeatherViewModel(latitude: String, longitude: String) {
        
        weatherViewModel.weatherList(lat: latitude, long: longitude)
        weatherViewModel.weather(lat: latitude, long: longitude)
    }
    
    private func setLabels() {
        
        tempValue.text = String(weatherViewModel.currentTemp)
        tempCondition.text = weatherViewModel.condition.uppercased()
        minTemp.text = String(weatherViewModel.minTemp) + "˚"
        currentTemp.text = String(weatherViewModel.currentTemp) + "˚"
        maxTemp.text = String(weatherViewModel.maxTemp) + "˚"
    }
    
    private func toggleThemes(theme: String, weatherCondition: String) {
        let pageTheme = weatherViewModel.toggleThemes(theme: theme,
                                                      condition: weatherCondition)
        reloadView()
        themeImage.image = UIImage(named: pageTheme[0])
        forcastedTableView.backgroundColor = UIColor(named: pageTheme[1])
        bottomView.backgroundColor = UIColor(named: pageTheme[1])
    }
    
    private func setWeatherViewController() {
        
        setCoreLocation()
        setTableView()
        currentTemperatureView.addBorder(side: .bottom, color: .white, width: 0.5)
        toggleThemes(theme: theme, weatherCondition: weatherViewModel.condition.lowercased())
    }
    
    func currentLocation() {
        
        let status = locationManager.authorizationStatus
        locationManager.requestWhenInUseAuthorization()
        
        if(status == .denied || status == .restricted || !CLLocationManager.locationServicesEnabled()) {
            return
        }
        
        if(status == .notDetermined) {
            locationManager.requestWhenInUseAuthorization()
            return
        }
        
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestLocation()
    }
}

extension WeatherViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        weatherViewModel.upcomingDaysCount
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = forcastedTableView.dequeueReusableCell(withIdentifier: "ForcastedWeatherCell", for: indexPath) as? ForcastedTableViewCell
        else {
            return ForcastedTableViewCell()
        }
        cell.setWeatherCell(day: weatherViewModel.day(atIndex:  indexPath.item),
                            temp: String(weatherViewModel.forcastedTemp(atIndex: indexPath.item)),
                            condition: weatherViewModel.condition.lowercased(), theme: theme)
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
    }
}

extension WeatherViewController:  ViewModelDelegate {
    func reloadView() {
        setLabels()
        self.forcastedTableView.reloadData()
    }
    
    func show(error: CustomError) {
        self.displayErrorAlert(title: error, errorMessage: error, buttonTitle: "OK")
    }
}

extension WeatherViewController : CLLocationManagerDelegate {
    
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        
        switch status {
        case .authorizedAlways:
            manager.requestLocation()
        case .authorizedWhenInUse:
            manager.requestLocation()
        case .denied:
            self.displayErrorAlert(title: .coreLocationDenied, errorMessage: .coreLocationDenied, buttonTitle: "OK")
        case .restricted:
            self.displayErrorAlert(title: .coreLocationDenied, errorMessage: .coreLocationDenied, buttonTitle: "OK")
        case .notDetermined:
            self.displayErrorAlert(title: .coreLocationNotFound, errorMessage: .coreLocationNotFound, buttonTitle: "OK")
        @unknown default:
            self.displayErrorAlert(title: .coreLocationNotFound, errorMessage: .coreLocationNotFound, buttonTitle: "OK")
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        
        let userLocation:CLLocation = locations[0] as CLLocation
        lat = String(format: "%.2f", userLocation.coordinate.latitude)
        long = String(format: "%.2f", userLocation.coordinate.longitude)
        setWeatherViewModel(latitude: lat, longitude: long)
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        
        self.displayErrorAlert(title: .coreLocationNotFound, errorMessage: .coreLocationNotFound, buttonTitle: "OK")
    }
}
