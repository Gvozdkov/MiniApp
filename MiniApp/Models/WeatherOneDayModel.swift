//
//  WeatherModel.swift
//  MiniApp
//
//  Created by Алексей Гвоздков on 06.09.2024.
//

import Foundation

struct WeatherOneDayModel: Codable {
    let main: Main
    let wind: Wind
    let weather: [Weather]
    let name: String
}

struct Main: Codable {
    let temp: Double
    let feels_like: Double
    let pressure: Int
    let humidity: Int
}

struct Weather: Codable {
    let description: String
}

struct Wind: Codable {
    let speed: Double
    let deg: Int
    let gust: Double
}
