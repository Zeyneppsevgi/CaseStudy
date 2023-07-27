//
//  WeatherResponse.swift
//  MVVMWeatherApp
//
//  Created by Zeynep Sevgi on 25.07.2023.
//

import Foundation

struct WeatherResponse : Codable {
    let lat: Double
    let lon: Double
    let timezone:String
    let current:Current
    let daily: [Daily]
}


struct Weather: Codable {
    let id: Int
    let main, description, icon: String
}

struct Current:Codable {
    let temp:Double
    let weather:[Weather]
}
struct Daily: Codable {
    let dt:Int64
    let temp: Temp
    let weather: [Weather]
}

struct Temp: Codable {
    let day,  night: Double
}

