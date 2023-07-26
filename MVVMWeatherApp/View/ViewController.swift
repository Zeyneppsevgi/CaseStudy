//
//  ViewController.swift
//  MVVMWeatherApp
//
//  Created by Zeynep Sevgi on 25.07.2023.
//

import UIKit

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var dereceLabel: UILabel!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var cityNameLabel: UILabel!
    
    @IBOutlet weak var tableView: UITableView!
    
    private var weatherViewModel=WeatherViewModel()
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        
        fetchWeather()
    }
    
    func fetchWeather(){
        self.weatherViewModel.fetchWeather(lat: 41.015137, lon: 28.979530, apiKey:"5a8907ac912c11c65ef98997c5f71c97") {(weather) in
            DispatchQueue.main.async {
                self.imageView.load(url: URL(string : self.weatherViewModel.getIcon(icon: weather.current.weather[0].icon))!)
                self.cityNameLabel.text = weather.timezone
                self.dereceLabel.text="\(weather.current.temp)"
                self.tableView.reloadData()
            }
        }
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
            cell.dayLabel.text = weatherViewModel.getDay(dt: dt)
            cell.tempGeceLabel.text = "\(weatherViewModel.dailyWeather![indexPath.row].temp.night)"
            cell.tempGunduzLabel.text = "\(weatherViewModel.dailyWeather![indexPath.row].temp.day)"
            let icon = weatherViewModel.dailyWeather![indexPath.row].weather[0].icon
            cell.imageViewIcon.load(url: URL(string : weatherViewModel.getIcon(icon: icon))!)
        }
        
        return cell
    }
    
    
    
    
}

