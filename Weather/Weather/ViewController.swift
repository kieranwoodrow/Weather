//
//  ViewController.swift
//  Weather
//
//  Created by Kieran Woodrow on 2022/04/21.
//

import UIKit
import Foundation

class ViewController: UIViewController {
    
    private lazy var weatherViewModel = WeatherViewModel(repository: WeatherRepository(),
                                                         delegate: self)
    @IBOutlet weak var testtableview: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        weatherViewModel.getWeather()
        setTableView()
        
    }
    
    private func setTableView() {
        testtableview.delegate = self
        testtableview.dataSource = self
    }
    
}

extension ViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = testtableview.dequeueReusableCell(withIdentifier: "test", for: indexPath) as? UITableViewCell
        else {
            return UITableViewCell()
        }
        
        cell.textLabel!.text = String(weatherViewModel.currentTemp)
        print(weatherViewModel.currentTemp)
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 400
    }
}

extension ViewController:  ViewModelDelegate {
    
    func reloadView() {
        self.testtableview.reloadData()
    }
    
    func show(error: CustomError) {
        
    }
}
