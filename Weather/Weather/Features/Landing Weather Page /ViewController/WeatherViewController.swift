//
//  WeatherViewController.swift
//  Weather
//
//  Created by Kieran Woodrow on 2022/04/21.
//

import UIKit
import Foundation

class WeatherViewController: UIViewController {
    
    @IBOutlet weak private var tempValue: UILabel!
    @IBOutlet weak private var tempCondition: UILabel!
    @IBOutlet weak private var currentTempView: UIView!
    @IBOutlet weak private var minTemp: UILabel!
    @IBOutlet weak private var currentTemp: UILabel!
    @IBOutlet weak private var maxTemp: UILabel!
    @IBOutlet weak private var forcastedTableView: UITableView!

    private lazy var weatherViewModel = WeatherViewModel(repository: WeatherRepository(),
                                                         delegate: self)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setViewController()
    }
    
    private func setTableView() {
        forcastedTableView.delegate = self
        forcastedTableView.dataSource = self
    }
    
    private func setWeatherViewModel() {
        weatherViewModel.weatherList()
        weatherViewModel.weather()
    }
    
    private func setLabels() {
        tempValue.text = String(weatherViewModel.currentTemp)
        tempCondition.text = weatherViewModel.condition.uppercased()
        minTemp.text = String(weatherViewModel.minTemp) + "˚"
        currentTemp.text = String(weatherViewModel.currentTemp) + "˚"
        maxTemp.text = String(weatherViewModel.maxTemp) + "˚"
    }
    
    private func setViewController() {
        setTableView()
        setWeatherViewModel()
        currentTempView.addBorder(side: .bottom, color: .white, width: 0.5)
        
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
