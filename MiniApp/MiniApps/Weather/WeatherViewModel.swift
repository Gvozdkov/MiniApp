//
//  WeatherViewModel.swift
//  MiniApp
//
//  Created by Алексей Гвоздков on 06.09.2024.
//

import Foundation
import CoreLocation

final class WeatherViewModel: NSObject {
    var onWeatherDataReceived: (() -> Void)?
    private(set) var city: String = "Moscow" {
        didSet {
                fetchWeatherOneDay(city: city)
        }
    }
    
    private(set) var weather: WeatherOneDayModel?
    
    public var locationManager = CLLocationManager()

    override init() {
        super.init()
        locationManager.delegate = self
    }
    
    private func setupLocationManager() {
        locationManager.delegate = self
        locationManager.requestWhenInUseAuthorization()
    }
    
    private func fetchCityFromLocation(_ location: CLLocation) {
        let geocoder = CLGeocoder()
        geocoder.reverseGeocodeLocation(location) { [weak self] placemarks, error in
            if let error = error {
                print("Geocode error: \(error)")
                self?.city = "Moscow"
                return
            }
            
            if let placemark = placemarks?.first, let city = placemark.locality {
                self?.city = city
            } else {
                self?.city = "Moscow"
            }
        }
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
    
    func requestLocationAuthorization() {
        locationManager.requestWhenInUseAuthorization()
    }
    
    func fetchCurrentLocation() {
        locationManager.startUpdatingLocation()
    }
}

extension WeatherViewModel: CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let location = locations.last else { return }
        fetchCityFromLocation(location)
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print("Location error: \(error)")
    }

    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        switch status {
        case .authorizedWhenInUse, .authorizedAlways:
            locationManager.startUpdatingLocation()
        case .denied, .restricted, .notDetermined:
            print("Доступ к местоположению не разрешен или не определен")
        @unknown default:
            break
        }
    }
}
