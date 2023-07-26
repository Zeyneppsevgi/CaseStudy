//
//  WeatherViewModel.swift
//  MVVMWeatherApp
//
//  Created by Zeynep Sevgi on 25.07.2023.
//

import Foundation


class WeatherViewModel {
    var dailyWeather:[Daily]?
    func fetchWeather(lat:Double, lon:Double, apiKey:String, competion: @escaping(WeatherResponse) -> ()){
        Webservice().fetchWeather(lat:lat, lon:lon, apiKey: apiKey) {(weather) in
            
            //   if let weather {
            //  self.dailyWeather = weather.daily[1 ... weather.daily.count!]
            // competion(weather)
            // }
            if let weather {
                if weather.daily.count > 1 {
                    let startIndex = 1
                    let endIndex = weather.daily.count - 1
                    self.dailyWeather = Array(weather.daily[startIndex...endIndex])
                    competion(weather)
                } else {
                    
                }
            }
            
        }
    }
    
    func getDay(dt:Int64) -> String{
        return "Salı"
    }
    
    func getIcon(icon:String)->String{
        return "https://openweathermap.org/img/wn/\(icon)@2x.png"
    }
    
}





