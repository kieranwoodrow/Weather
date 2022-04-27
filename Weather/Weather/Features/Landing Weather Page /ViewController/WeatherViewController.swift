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
    
    @IBOutlet weak private var tempValue: UILabel!
    @IBOutlet weak private var tempCondition: UILabel!
    @IBOutlet weak private var currentTempView: UIView!
    @IBOutlet weak private var minTemp: UILabel!
    @IBOutlet weak private var currentTemp: UILabel!
    @IBOutlet weak private var maxTemp: UILabel!
    @IBOutlet weak private var forcastedTableView: UITableView!
    private let locationManager = CLLocationManager()
    
    private lazy var weatherViewModel = WeatherViewModel(repository: WeatherRepository(),
                                                         delegate: self)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setWeatherViewController()
    }
    
    private func setTableView() {
        forcastedTableView.delegate = self
        forcastedTableView.dataSource = self
    }
    
    private func setWeatherViewModel() {
        weatherViewModel.weatherList()
        weatherViewModel.weather()
    }
    
    private func setCoreLocation() {
        locationManager.delegate = self
    }
    
    private func setLabels() {
        tempValue.text = String(weatherViewModel.currentTemp)
        tempCondition.text = weatherViewModel.condition.uppercased()
        minTemp.text = String(weatherViewModel.minTemp) + "˚"
        currentTemp.text = String(weatherViewModel.currentTemp) + "˚"
        maxTemp.text = String(weatherViewModel.maxTemp) + "˚"
    }
    
    private func setWeatherViewController() {
        setCoreLocation()
        setTableView()
        setWeatherViewModel()
        currentTempView.addBorder(side: .bottom, color: .white, width: 0.5)
    }
    
    func retriveCurrentLocation(){
        let status = locationManager.authorizationStatus

        if(status == .denied || status == .restricted || !CLLocationManager.locationServicesEnabled()){
            // show alert to user telling them they need to allow location data to use some feature of your app
            return
        }

        // if haven't show location permission dialog before, show it to user
        if(status == .notDetermined){
            locationManager.requestWhenInUseAuthorization()

            // if you want the app to retrieve location data even in background, use requestAlwaysAuthorization
            // locationManager.requestAlwaysAuthorization()
            return
        }
        
        // at this point the authorization status is authorized
        // request location data once
        locationManager.requestLocation()
      
        // start monitoring location data and get notified whenever there is change in location data / every few seconds, until stopUpdatingLocation() is called
        // locationManager.startUpdatingLocation()
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
        cell.setRocketCell(day: weatherViewModel.day(atIndex:  indexPath.item),
                           temp: String(weatherViewModel.forcastedTemp(atIndex: indexPath.item)),
                           condition: weatherViewModel.forcastedCondition(atIndex: indexPath.item).lowercased())
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
    }
}

extension WeatherViewController:  ViewModelDelegate {
    func reloadView() {
        
        self.forcastedTableView.reloadData()
        setLabels()
    }
    
    func show(error: CustomError) {
        
    }
}
    
extension WeatherViewController : CLLocationManagerDelegate {
    // called when the authorization status is changed for the core location permission
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        print("location manager authorization status changed")
        
        switch status {
        case .authorizedAlways:
            print("user allow app to get location data when app is active or in background")
        case .authorizedWhenInUse:
            print("user allow app to get location data only when app is active")
        case .denied:
            print("user tap 'disallow' on the permission dialog, cant get location data")
        case .restricted:
            print("parental control setting disallow location data")
        case .notDetermined:
            print("the location permission dialog haven't shown before, user haven't tap allow/disallow")
        @unknown default:
            <#fatalError()#>
        }
    }
}

