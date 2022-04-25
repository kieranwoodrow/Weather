//
//  WeatherViewController.swift
//  Weather
//
//  Created by Kieran Woodrow on 2022/04/21.
//

import UIKit
import Foundation

class WeatherViewController: UIViewController {
    
    private lazy var weatherViewModel = WeatherViewModel(repository: WeatherRepository(),
                                                         delegate: self)
    
    @IBOutlet weak private var tempValue: UILabel!
    @IBOutlet weak private var tempCondition: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        weatherViewModel.getWeather()
//        setTableView()
        tempValue.text = String(weatherViewModel.currentTemp)
        tempCondition.text = weatherViewModel.condition
        
        
    }
    
//    private func setTableView() {
//        testtableview.delegate = self
//        testtableview.dataSource = self
//    }
    
}

//extension WeatherViewController: UITableViewDelegate, UITableViewDataSource {
//
//    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        1
//    }
//
//    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//
//        guard let cell = testtableview.dequeueReusableCell(withIdentifier: "test", for: indexPath) as? UITableViewCell
//        else {
//            return UITableViewCell()
//        }
//
//        cell.textLabel!.text = String(weatherViewModel.currentTemp)
//        print(weatherViewModel.currentTemp)
//        return cell
//    }
//
//    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
//        return 400
//    }
//}

extension WeatherViewController:  ViewModelDelegate {
    
    func reloadView() {
        //self.testtableview.reloadData()
    }
    
    func show(error: CustomError) {
        
    }
}

