//
//  WeatherLocation.swift
//  WeatherGift
//
//  Created by William Templeton on 3/22/20.
//  Copyright © 2020 William Templeton. All rights reserved.
//

import Foundation

class WeatherLocation: Codable {
    var name: String
    var longitude: Double
    var latitude: Double
    
    init(name: String, latitude: Double, longitude: Double) {
        self.name = name
        self.latitude = latitude
        self.longitude = longitude
    }
    
  
}
