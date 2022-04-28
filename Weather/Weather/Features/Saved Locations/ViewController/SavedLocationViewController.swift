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
    
    private var locations: [Location] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setTableView()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        savedLocationViewModel.allLocations()
    }
    
    private func setTableView() {
        
        locationsTableView.delegate = self
        locationsTableView.dataSource = self
    }
}

extension SavedLocationViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        savedLocationViewModel.locationsCount
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = locationsTableView.dequeueReusableCell(withIdentifier: "savedlocation", for: indexPath) as? SavedLocationTableViewCell
        else {
            return SavedLocationTableViewCell()
        }
        
        let lat = savedLocationViewModel.locations[indexPath.item].value(forKey: "latitude").unsafelyUnwrapped
        let long = savedLocationViewModel.locations[indexPath.item].value(forKey: "longitude").unsafelyUnwrapped
        let details = "Saved location: lat: \(lat); long \(long)"
        cell.setLocation(locationDetails: details)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
    }
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        
        let action = UIContextualAction(style: .destructive, title: "Delele") { (_, _, _) in
            
            let location = self.savedLocationViewModel.locations[indexPath.item]
            Constants.coreDataPersistantObject?.delete(location)
            
            do {
                try Constants.coreDataPersistantObject?.save()
            } catch {
                
            }
            self.savedLocationViewModel.allLocations()
        }
        return UISwipeActionsConfiguration(actions: [action])
    }
}

extension SavedLocationViewController:  ViewModelDelegate {
    func reloadView() {
        
        self.locationsTableView.reloadData()
    }
    
    func show(error: CustomError) {
        self.displayErrorAlert(title: error, errorMessage: error, buttonTitle: "OK")
    }
}
