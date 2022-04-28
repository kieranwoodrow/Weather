//
//  SavedLocationTableViewCell.swift
//  Weather
//
//  Created by Kieran Woodrow on 2022/04/28.
//

import Foundation
import UIKit

class SavedLocationTableViewCell: UITableViewCell {
    
    @IBOutlet weak private var location: UILabel!
    
    func setLocation(locationDetails: String) {
        location.text = locationDetails
    }
}
