//
//  ViewController.swift
//  WeatherApp
//
//  Created by Mehmet Ergün on 2022-08-09.
//

import UIKit
import CoreLocation

class ViewController: UIViewController {

    @IBOutlet weak var cityNameLabel: UILabel!
    @IBOutlet weak var temperatureLabel: UILabel!
    @IBOutlet weak var feelsLikeTempLabel: UILabel!
    @IBOutlet weak var weatherImageView: UIImageView!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var minTempLabel: UILabel!
    @IBOutlet weak var maxTempLabel: UILabel!
    @IBOutlet weak var pressureLabel: UILabel!
    @IBOutlet weak var humidityLabel: UILabel!
    @IBOutlet weak var wiindSpeedLabel: UILabel!
    @IBOutlet weak var windDegreeLabel: UILabel!
    @IBOutlet weak var searchTextField: UITextField!
    @IBOutlet weak var searchButton: UIButton!
    
    var weatherModel: WeatherModel?

    var weatherManager = WeatherManager()
    
    var locationManager = CLLocationManager()

    override func viewDidLoad() {
        super.viewDidLoad()

        searchTextField.delegate = self
        weatherManager.delegate = self
        
        locationManager.delegate = self
        locationManager.requestWhenInUseAuthorization()
        locationManager.requestLocation()
        
        view.backgroundColor = .systemBackground
//        searchButton.tintColor = .systemBackground
        view.tintColor = .systemBackground
        
    }
    
    @IBAction func locationButtonPressed(_ sender: UIButton) {
        locationManager.requestLocation()
    }
    


    func makeAlert() {
        let alert = UIAlertController(title: "Type something", message: "You should type a city in search bar!", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        present(alert, animated: true)
    }
}

//MARK: - UITextFieldDelegate

extension ViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        searchTextField.endEditing(true)
        return true

    }

    func textFieldDidEndEditing(_ textField: UITextField) {

        if let city = searchTextField.text {
            weatherManager.fetchWeather(cityName: city)

            cityNameLabel.text = city
        }

        searchTextField.text = ""
    }

    func textFieldShouldEndEditing(_ textField: UITextField) -> Bool {
        if textField.text != "" {
            return true
        } else {
            makeAlert()
            textField.placeholder = "Type a city..."
            return false
        }
    }

    @IBAction func searchButtonPressed(_ sender: UIButton) {

        searchTextField.endEditing(true)
    }
}

//MARK: - WeatherManagerDelegate

extension ViewController: WeatherManagerDelegate {
    func updateWeather(weatherManager: WeatherManager, weather: WeatherModel) {
        
        DispatchQueue.main.async { [self] in
            
            self.temperatureLabel.text = "\(weather.temperatureString)°"
            self.weatherImageView.image = UIImage(named: weather.conditionName)
            self.cityNameLabel.text = weather.cityName
            self.maxTempLabel.text = "Max Temp: \(weather.maxTempString)°"
            self.minTempLabel.text = "Min Temp: \(weather.minTempString)°"
            self.feelsLikeTempLabel.text = "Feels Like: \(weather.feelsLikeString)°"

            self.pressureLabel.text = "Pressure: \(weather.pressure)"
            self.humidityLabel.text = "Humidity: \(weather.humidity)"
            self.wiindSpeedLabel.text = "Wind Speed: \(weather.windSpeed)"
            self.windDegreeLabel.text = "Wind Deg: \(weather.WindDeg)"
            self.descriptionLabel.text = weather.description
            
            if weatherImageView.image == UIImage(named: "cloudFog") {
                view.backgroundColor = UIColor(patternImage: UIImage(named: "cloudFog")!)
                assignTextColor(color: .white)
            }else if weatherImageView.image == UIImage(named: "cloudBolt-1")  {
                view.backgroundColor = UIColor(patternImage: UIImage(named: "cloudBolt")!)
                assignTextColor(color: .white)
            }else if weatherImageView.image == UIImage(named: "cloudSnow") {
                view.backgroundColor = UIColor(patternImage: UIImage(named: "snow")!)
                view.tintColor = .black
                assignTextColor(color: .black)
                self.cityNameLabel.textColor = .black
            }else if weatherImageView.image == UIImage(named: "sunMax-1") {
                view.backgroundColor = UIColor(patternImage: UIImage(named: "sunMax")!)
                assignTextColor(color: .white)
            }else if weatherImageView.image == UIImage(named: "cloudDrizzle-1") {
                view.backgroundColor = UIColor(patternImage: UIImage(named: "rain")!)
                assignTextColor(color: .white)
            }else if weatherImageView.image == UIImage(named: "cloudFew") {
                view.backgroundColor = UIColor(patternImage: UIImage(named: "cloudDrizzle")!)
                
                assignTextColor(color: .white)
            }
            }
        
        func assignTextColor(color: UIColor) {
            self.cityNameLabel.textColor = color
            self.temperatureLabel.textColor = color
            self.minTempLabel.textColor = color
            self.maxTempLabel.textColor = color
            self.pressureLabel.textColor = color
            self.humidityLabel.textColor = color
            self.windDegreeLabel.textColor = color
            self.wiindSpeedLabel.textColor = color
            self.descriptionLabel.textColor = color
            self.feelsLikeTempLabel.textColor = color
        }
    }
    
    func didFailWithError(error: Error) {
        print(error)
    }
}

//MARK: - CLLocationManagerDelegate

extension ViewController: CLLocationManagerDelegate {
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let location = locations.last {
            locationManager.stopUpdatingLocation()
            let lat = location.coordinate.latitude
            let lon  = location.coordinate.longitude
            weatherManager.fetchWeather(latitude: lat, longitude: lon)
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print(error)
    }
}



