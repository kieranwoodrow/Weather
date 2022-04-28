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
    private var color = UIColor()
    private var iconName = ""
    
    func set(weatherIcon: String) {
        if let safeIcon = UIImage(named: weatherIcon) {
            icon = safeIcon
        }
    }
    
    func set(colour: String) -> UIColor {
        if let safeColour = UIColor(named: colour) {
            color = safeColour
        }
        return color
    }
    
    func set(day: String) {
        self.day.text = day
    }
    
    func set(temperature: String) {
        self.temperature.text = temperature + "˚"
    }
    
    func set(theme: String, condition: String) {
        if theme == Constants.themes[0] {
            set(forrestBackgroundColour: condition)
        } else {
            set(seaBackgroundColour: condition)
        }
    }
    
    func set(forrestBackgroundColour: String) {
        var colours = ""
        
        switch forrestBackgroundColour {
        case forrestBackgroundColour where Constants.rainyCondition.contains(where: forrestBackgroundColour.contains):
            colours = "Rainy"
        case forrestBackgroundColour where Constants.sunnyCondition.contains(where: forrestBackgroundColour.contains):
            colours = "Sunny"
        case forrestBackgroundColour where Constants.cloudyCondition.contains(where: forrestBackgroundColour.contains):
            colours = "Cloudy"
        default:
            colours = "Cloudy"
        }
        
        self.backgroundColor = set(colour: colours)
    }
    
    func set(seaBackgroundColour: String) {
        var colours = ""
        
        switch seaBackgroundColour {
        case seaBackgroundColour where Constants.rainyCondition.contains(where: seaBackgroundColour.contains):
            colours = "Rainy"
        case seaBackgroundColour where Constants.sunnyCondition.contains(where: seaBackgroundColour.contains):
            colours = "Ocean"
        case seaBackgroundColour where Constants.cloudyCondition.contains(where: seaBackgroundColour.contains):
            colours = "Cloudy"
        default:
            colours = "Ocean"
        }
        
        self.backgroundColor = set(colour: colours)
    }
    
    func set(iconImage: String) {
        switch iconImage {
        case iconImage where Constants.cloudyCondition.contains(where: iconImage.contains ):
            iconName = "CloudyIcon"
            set(weatherIcon: iconName)
        case iconImage where Constants.rainyCondition.contains(where: iconImage.contains):
            iconName = "RainyIcon"
            set(weatherIcon: iconName)
        case iconImage where Constants.sunnyCondition.contains(where: iconImage.contains):
            iconName = "SunnyIcon"
            set(weatherIcon: iconName)
        default:
            set(weatherIcon: "CloudyIcon")
        }
        
        self.weatherIcon.image = icon
    }
    
    func setWeatherCell(day: String, temp: String, condition: String, theme: String) {
        set(day: day)
        set(temperature: temp)
        set(iconImage: condition)
        set(theme: theme, condition: condition)
    }
}
