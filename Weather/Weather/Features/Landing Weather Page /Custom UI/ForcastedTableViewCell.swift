//
//  ForcastedTableViewCell.swift
//  Weather
//
//  Created by Kieran Woodrow on 2022/04/27.
//

import Foundation
import UIKit

class ForcastedTableViewCell: UITableViewCell {
    
    @IBOutlet weak private var weatherIcon: UIImageView!
    @IBOutlet weak private var temperature: UILabel!
    @IBOutlet weak private var day: UILabel!
    private var icon = UIImage()
    private var iconName = ""
    private var sunnyIcon = ["clear"]
    private var partlyCloudyIcon = ["drizzle"]
    private var cloudyIcon = ["thunderstorm", "drizzle", "rain",
                              "snow","tornado", "mist", "smoke",
                              "haze", "dust","fog", "sand", "ash", "squall"]
    
    func set(condition: String) {
        switch condition {
        case condition where partlyCloudyIcon.contains(where: condition.contains):
            iconName = "partlyCloudy"
            setIcon(name: iconName)
        case condition where cloudyIcon.contains(where: condition.contains):
            iconName = "Rainy"
            setIcon(name: iconName)
        case condition where sunnyIcon.contains(where: condition.contains):
            iconName = "Clear"
            setIcon(name: iconName)
        default:
            setIcon(name: "Clear")
        }
        
        self.weatherIcon.image = icon
    }
    
    func setIcon(name: String) {
        if let safeIcon = UIImage(named: name) {
            icon = safeIcon
        }
    }
    
    func set(day: String) {
        self.day.text = day
    }
    
    func set(temperature: String) {
        self.temperature.text = temperature + "˚"
    }
    
    func setRocketCell(day: String, temp: String, condition: String) {
        set(day: day)
        set(temperature: temp)
        set(condition: condition)
    }
}
