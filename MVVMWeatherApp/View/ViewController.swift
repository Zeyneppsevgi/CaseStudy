//
//  ViewController.swift
//  MVVMWeatherApp
//
//  Created by Zeynep Sevgi on 25.07.2023.
//

import UIKit
import CoreLocation


class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource,ApiKeyViewControllerDelegate {
    
    @IBOutlet weak var dereceLabel: UILabel!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var cityNameLabel: UILabel!
    
    @IBOutlet weak var tableView: UITableView!
    
    var latitude: Double!
    var longitude: Double!
    var apiKey : String = ""
    var city : String? = ""
 
  
    
    private var weatherViewModel=WeatherViewModel()
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
//        city = weatherViewModel.getLocation(lat: latitude, lon: longitude)
        weatherViewModel.getLocation(lat: latitude, lon: longitude) { success, address in
            if success {                
                self.cityNameLabel.text = address
            } else {
                print("errorrr")
            }
        }
        
        print("city= \(city)")
        fetchWeather()
        
    }
    
    
    
    func fetchWeather(){
        self.weatherViewModel.fetchWeather(lat: latitude!, lon: longitude!, apiKey:apiKey,competion: {(weather) in
            DispatchQueue.main.async {
                self.imageView.load(url: URL(string : self.weatherViewModel.getIcon(icon: weather.current.weather[0].icon))!)
                self.dereceLabel.text="\(Int(weather.current.temp - 273.15))°C"
                self.tableView.reloadData()
                
            }
        }
    )}
    func didLatWithLon(_ lat: Double, lon: Double, apiKey: String) {
        self.latitude = lat
        self.longitude = lon
        self.apiKey = apiKey
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if  weatherViewModel.dailyWeather != nil {
            return weatherViewModel.dailyWeather!.count
        } else{
            return 0
        }
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "WeatherCell", for: indexPath) as! WeatherTableViewCell
        if  weatherViewModel.dailyWeather != nil {
            let dt = weatherViewModel.dailyWeather![indexPath.row].dt
            cell.dayLabel.text = "\(weatherViewModel.getDay(dt: TimeInterval(dt)))"
            cell.tempGeceLabel.text = "\(Int(weatherViewModel.dailyWeather![indexPath.row].temp.night - 273.15))°C"
            cell.tempGunduzLabel.text = "\(Int(weatherViewModel.dailyWeather![indexPath.row].temp.day - 273.15))°C"
            let icon = weatherViewModel.dailyWeather![indexPath.row].weather[0].icon
            cell.imageViewIcon.load(url: URL(string : weatherViewModel.getIcon(icon: icon))!)
            
        }
        
        return cell
    }
    
    
    
    
}

