//
//  WeatherManager.swift
//  WeatherApp
//
//  Created by Mehmet Ergün on 2022-08-10.
//

import Foundation
import CoreLocation

protocol WeatherManagerDelegate {
    func updateWeather(weatherManager: WeatherManager, weather: WeatherModel)
    func didFailWithError(error: Error)
}

struct WeatherManager {
    
    var delegate: WeatherManagerDelegate?
    
    let weatherURL = "https://api.openweathermap.org/data/2.5/weather?&units=metric&appid=b0ad8806e76558802328f1a264b73e92"
    
    func fetchWeather(cityName: String){
        let urlString = "\(weatherURL)&q=\(cityName)"
        performRequest(with: urlString)
    }
    
    func fetchWeather(latitude: CLLocationDegrees, longitude: CLLocationDegrees) {
        let urlString = "\(weatherURL)&lat=\(latitude)&lon=\(longitude)"
        performRequest(with: urlString)
    }
    
    func performRequest(with urlString: String) {
           if let url = URL(string: urlString) {
               let session = URLSession(configuration: .default)
               let task = session.dataTask(with: url) { (data, response, error) in
                   if error != nil {
                       self.delegate?.didFailWithError(error: error!)
                       return
                   }
                   if let safeData = data {
                       if let weather =  self.parseJSON(safeData){
                           self.delegate?.updateWeather(weatherManager: self, weather: weather)
                       }
                   }
               }
               task.resume()
           }
       }
    
    func parseJSON(_ weatherData: Data) -> WeatherModel? {
        let decoder = JSONDecoder()
        
        do {
            let decodedData = try decoder.decode(WeatherData.self, from: weatherData)
            let id = decodedData.weather[0].id
            let temp = decodedData.main.temp
            let cityName = decodedData.name
            let minTemp = decodedData.main.temp_min
            let maxTemp = decodedData.main.temp_max
            let feelsLike = decodedData.main.feels_like
            let pressure = decodedData.main.pressure
            let humidity = decodedData.main.humidity
            let windSpeed = decodedData.wind.speed
            let windDeg = decodedData.wind.deg
            let description = decodedData.weather[0].description
            
            let weather = WeatherModel(conditionId: id, cityName: cityName, temperature: temp, minTemp: minTemp, maxTemp: maxTemp, feelsLike: feelsLike, pressure: pressure, humidity: humidity, windSpeed: windSpeed, WindDeg: windDeg, description: description)
            return weather
            
        } catch  {
            delegate?.didFailWithError(error: error)
            return nil
        }
    }
}
