//
//  WeatherViewModel.swift
//  MVVMWeatherApp
//
//  Created by Zeynep Sevgi on 25.07.2023.
//

import Foundation
import CoreLocation


class WeatherViewModel {
    var dailyWeather:[Daily]?
    func fetchWeather(lat:Double, lon:Double, apiKey:String, competion: @escaping(WeatherResponse) -> ()){
        Webservice().fetchWeather(lat:lat, lon:lon, apiKey: apiKey) {(weather) in
            
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
    
    func getDay(dt:TimeInterval) -> String {
        let date = Date(timeIntervalSince1970: dt)
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "EEEE"
        return dateFormatter.string(from: date)
    }
    
    func getIcon(icon:String)->String{
        return "https://openweathermap.org/img/wn/\(icon)@2x.png"
    }
    
    
    func getLocation(lat: Double , lon:Double, _ completion:  @escaping(_ success: Bool, _ address: String?) -> Void) -> Void {
        let ceo: CLGeocoder = CLGeocoder()

        let loc: CLLocation = CLLocation(latitude: lat, longitude: lon)
        ceo.reverseGeocodeLocation(loc , completionHandler: { (placemarks,error) in
            if(error != nil) {
                print("error")
            }
            
            let pm = placemarks! as [CLPlacemark]
            var address : String = ""
            if pm.count > 0 {
                let pm = placemarks![0]
                address = "\(pm.administrativeArea ?? "xx"), \(pm.isoCountryCode ?? "yy")"
                completion(true, address)
            }else {
                completion(false,nil)
            }
        })
    }
}








