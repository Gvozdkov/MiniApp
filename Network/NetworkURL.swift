//
//  NetworkURL.swift
//  MiniApp
//
//  Created by Алексей Гвоздков on 06.09.2024.
//

import Foundation

enum NetworkURL {
    case weather(city: String)
    case map
    
    var url: URL? {
        switch self {
        case .weather(let city):
            let apiKey = "9e3c2f666b0e284e9d40e0331813110f"
            let baseUrl = "https://api.openweathermap.org/data/2.5/weather"
            let urlString = "\(baseUrl)?q=\(city)&appid=\(apiKey)&units=metric"
            return URL(string: urlString)
        case .map:
            return URL(string: "https://yandex.ru/maps")
        }
    }
}
