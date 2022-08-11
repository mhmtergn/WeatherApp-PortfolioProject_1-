//
//  WeatherModel2.swift
//  WeatherApp
//
//  Created by Mehmet Ergün on 2022-08-10.
//

import Foundation
import UIKit


struct WeatherModel {
    let conditionId: Int
    let cityName: String
    let temperature: Double
    let minTemp: Double
    let maxTemp: Double
    let feelsLike: Double
    let pressure: Int
    let humidity: Int
    let windSpeed: Double
    let WindDeg: Int
    let description: String


    var temperatureString: String {
        return String(format: "%.1f", temperature)
    }

    var minTempString: String {
        return String(format: "%.1f", minTemp)
    }

    var maxTempString: String {
        return String(format: "%.1f", maxTemp)
    }

    var feelsLikeString: String {
        return String(format: "%.1f", feelsLike)
    }

    var pressureString: String {
        return "Pressure: \(pressure)"
    }

    var humidityString: String {
        return "Humidity: \(humidity)"
    }

    var windSpeedString: String {
        return String(format: "%.1f", windSpeed)
    }

    var windDegString: String {
        return "Wind Deg: \(WindDeg)"
    }


    var conditionName: String {
        switch conditionId {
        case 200...232:
            return "cloudBolt-1"
        case 300...321:
            return "cloudDrizzle-1"
        case 500...531:
            return "cloudDrizzle-1"
        case 600...622:
            return "cloudSnow"
        case 701...781:
            return "cloudFog-1"
        case 800:
            return "sunMax-1"
        case 801...804:
            return "cloudFew"
        default:
            return "cloud"
        }
        


    }

}

