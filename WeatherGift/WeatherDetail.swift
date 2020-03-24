//
//  WeatherDetail.swift
//  WeatherGift
//
//  Created by William Templeton on 3/23/20.
//  Copyright © 2020 William Templeton. All rights reserved.
//

import Foundation

class WeatherDetail: WeatherLocation {
    
    struct Result: Codable {
        var timezone: String
        var currently: Currently
        var daily: Daily
    }
    struct Currently: Codable {
        var temperature: Double
    }
    
    struct Daily: Codable {
        var summary: String
        var icon: String
    }
    var timezone = ""
    var temperature = 0
    var summary = ""
    var dailyIcon = ""
    
    func getData(completed: @escaping () -> () ) {
        let coordinates = "\(latitude),\(longitude)"
        let urlString = "\(APIurls.darkSkyURL)\(APIkeys.darkSkyKey)/\(coordinates)"
        
        print("We are accessing URL \(urlString)")
        
        //Create a URL
        guard let url = URL(string: urlString) else {
            print("🚫 ERROR: Could not create a URL from \(urlString)")
            completed()
            return
        }
        //Create Session
        let session = URLSession.shared
        
        //Get Data
        let task = session.dataTask(with: url) { (data, response, error) in
            if let error = error {
                print("🚫 ERROR: \(error.localizedDescription)")
            }
            
            //Deal with the data
            do {
                let result = try JSONDecoder().decode(Result.self, from: data!)
                print("The timezone for \(self.name) is: \(result.timezone)")
                self.timezone = result.timezone
                self.temperature = Int(result.currently.temperature.rounded())
                self.summary = result.daily.summary
                self.dailyIcon = result.daily.icon
            } catch {
                print("🚫 JSON ERROR: \(error.localizedDescription)")
            }
            completed()
        }
        
        task.resume()
    }
}
