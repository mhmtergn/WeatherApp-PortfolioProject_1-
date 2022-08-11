//
//  WeatherModel.swift
//  WeatherApp
//
//  Created by Mehmet Ergün on 2022-08-09.
//

import Foundation

struct WeatherModel: Codable {
    var weather: [Weather]
    var main: Main
    var wind: Wind
    var name: String
}

struct Weather: Codable {
    var id: Int
    var description: String
    var icon: String
}

struct Main: Codable {
    var temp: Double
    var feels_like: Double
    var temp_min: Double
    var temp_max: Double
    var pressure: Int
    var humidity: Int
}


struct Wind: Codable {
    var speed: Double
    var deg: Int
}
