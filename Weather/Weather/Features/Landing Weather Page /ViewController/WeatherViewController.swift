//
//  WeatherViewController.swift
//  Weather
//
//  Created by Kieran Woodrow on 2022/04/21.
//

import UIKit
import Foundation

class WeatherViewController: UIViewController {
    
    @IBOutlet weak private var forcastedTableView: UITableView!
    private lazy var weatherViewModel = WeatherViewModel(repository: WeatherRepository(),
                                                         delegate: self)
    
    @IBOutlet weak private var tempValue: UILabel!
    @IBOutlet weak private var tempCondition: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setWeatherViewModel()
        setTableView()
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
        tempCondition.text = weatherViewModel.condition
    }
}

extension WeatherViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        weatherViewModel.weatherListCount
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = forcastedTableView.dequeueReusableCell(withIdentifier: "ForcastedWeatherCell", for: indexPath) as? UITableViewCell
        else {
            return UITableViewCell()
        }
        
        setLabels()
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 400
    }
}

extension WeatherViewController:  ViewModelDelegate {
    
    func reloadView() {
        self.forcastedTableView.reloadData()
    }
    
    func show(error: CustomError) {
        
    }
}
