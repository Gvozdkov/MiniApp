//
//  WeatherViewModel.swift
//  MiniApp
//
//  Created by Алексей Гвоздков on 06.09.2024.
//

import Foundation

final class WeatherViewModel {
    var onWeatherDataReceived: (() -> Void)?
    private(set) var city = "Moscow" {
        didSet {
            fetchWeatherOneDay(city: city)
        }
    }
    
    private(set) var weather: WeatherOneDayModel?
    
       init() {
           fetchWeatherOneDay(city: city)
    }
    
    func fetchWeatherOneDay(city: String) {
        guard let url = NetworkURL.weather(city: city).url else {
            print("Invalid URL")
            return
        }
        
        NetworkManager.shared.fetchData(from: url) { result in
            switch result {
            case .success(let data):
                do {
                    let decoder = JSONDecoder()
                    let response = try decoder.decode(WeatherOneDayModel.self, from: data)
                    self.weather = response
                    self.onWeatherDataReceived?()
                } catch {
                    print("Error decoding data: \(error)")
                }
            case .failure(let error):
                print("Error network weather \(error)")
            }
        }
    }
}
