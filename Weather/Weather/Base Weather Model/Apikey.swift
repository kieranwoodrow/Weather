//
//  Apikey.swift
//  Weather
//
//  Created by Kieran Woodrow on 2022/04/24.
//

import Foundation

struct Apikey {
    var apiKey: String {
        return Bundle.main.infoDictionary?["API_KEY"] as? String ?? ""
    }
}
