//
//  WeatherManager.swift
//  Clima
//
//  Created by Kássio Vieira da Luz on 03/06/21.
//  Copyright © 2021 App Brewery. All rights reserved.
//

import Foundation

struct WeatherManager {
    let weatherURL = "https://api.openweathermap.org/data/2.5/weather?appid=6b0fe096777af442e29feb742ccfdea0&units=metric"
    
    
    func fetchWeather(cityName: String){
        let urlString = "\(weatherURL)&q=\(cityName)"
        performRequest(urlString: urlString)
    }
    
    func performRequest(urlString: String){
        if let url = URL(string: urlString){
            let session = URLSession(configuration: .default)
            let task = session.dataTask(with: url, completionHandler: {(data, repsonse, error) in
                if error != nil {
                    print(error!)
                    return
                }
    
                if let safeData = data{
                    self.parseJSOn(weatherData: safeData)
                }
            })
            task.resume()
        }
    }
    
    func parseJSOn(weatherData: Data){
        let decoder = JSONDecoder()
        do {
            let decodedData = try decoder.decode(WeatherData.self, from: weatherData)
            print(decodedData.name)
            print(decodedData.main.temp)
            print(decodedData.weather[0].description)
        } catch {
            print(error)
        }
    }
}
