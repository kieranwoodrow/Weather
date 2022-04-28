//
//  SavedLocationViewController.swift
//  Weather
//
//  Created by Kieran Woodrow on 2022/04/28.
//

import Foundation
import UIKit

class SavedLocationViewController: UIViewController {

    @IBOutlet weak private var locationsTableView: UITableView!
    private lazy var savedLocationViewModel = SavedLocationViewModel(repository: SavedLocationRepository(),
                                                         delegate: self)
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
//    func setViewController() {
//        locations = savedLocationViewModel.locations
//    }
}

extension SavedLocationViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        savedLocationViewModel.locationsCount
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = locationsTableView.dequeueReusableCell(withIdentifier: "savedlocation", for: indexPath) as? UITableViewCell
        else {
            return UITableViewCell()
        }
        
        let lat = savedLocationViewModel.locations[indexPath.item].value(forKey: "latitude")
        let long = savedLocationViewModel.locations[indexPath.item].value(forKey: "longitude")
        cell. = "Your location is " + "latitude: \(lat) and longitude \(long) "
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
    }
}

extension SavedLocationViewController:  ViewModelDelegate {
    func reloadView() {
       
//        self.forcastedTableView.reloadData()
    }
    
    func show(error: CustomError) {
        self.displayErrorAlert(title: error, errorMessage: error, buttonTitle: "OK")
    }
}


