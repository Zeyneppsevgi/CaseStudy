//
//  Webservice.swift
//  MVVMWeatherApp
//
//  Created by Zeynep Sevgi on 25.07.2023.
//
//escaping: fonks tamamlandıktan sonra çağrılan argüman.
import Foundation

class Webservice {
    
    func fetchWeather(lat:Double,lon:Double,apiKey:String,competion: @escaping(WeatherResponse?) -> ()){
       
        let url = URL(string: "https://api.openweathermap.org/data/2.5/onecall?lat=\(lat)&lon=\(lon)&exclude=alerts,hourly,minutely&appid=5a8907ac912c11c65ef98997c5f71c97")
        URLSession.shared.dataTask(with: url!) { data, response, error in
            if let error = error {
                print(error.localizedDescription)
                competion(nil)
            } else if let data = data {
                //bütün datayı çekip işleme işlemi
                if let decodedResponse = try? JSONDecoder().decode(WeatherResponse?.self, from: data) {
                    competion(decodedResponse)
                }
            
            }
        }.resume()
    }
}
