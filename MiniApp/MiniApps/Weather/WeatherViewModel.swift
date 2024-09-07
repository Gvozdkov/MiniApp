//
//  WeatherViewModel.swift
//  MiniApp
//
//  Created by Алексей Гвоздков on 06.09.2024.
//

import Foundation
import CoreLocation

final class WeatherViewModel: NSObject {
    // Текущий выбранный город. При изменении города автоматически вызывается метод fetchWeatherOneDay для загрузки погоды
    private(set) var city: String = "Moscow" {
        didSet {
            fetchWeatherOneDay(city: city)  // Загружаем погоду для нового города
        }
    }
    
    // Модель данных для погоды на один день
    private(set) var weather: WeatherOneDayModel?
    
    // Менеджер для работы с местоположением
    public var locationManager = CLLocationManager()
    
    // Замыкание, которое вызывается после получения данных о погоде
    var onWeatherDataReceived: (() -> Void)?
    
    // Флаг, который отслеживает, идет ли поиск по городу
    var isSearchByCity: Bool = false
    
    // Флаг, чтобы запросить местоположение только один раз
    private var didFetchLocationOnce = false

    // Конструктор, назначает делегат для locationManager
    override init() {
        super.init()
        locationManager.delegate = self
    }
    
    // Настройка менеджера местоположения, запрашиваем разрешение на доступ к геолокации
    private func setupLocationManager() {
        locationManager.delegate = self
        locationManager.requestWhenInUseAuthorization()  // Запрашиваем разрешение на доступ к местоположению
    }
    
    // Получение города на основе текущих координат местоположения
    func fetchCityFromLocation(_ location: CLLocation) {
        let geocoder = CLGeocoder()
        geocoder.reverseGeocodeLocation(location) { [weak self] placemarks, error in
            if let error = error {
                print("Geocode error: \(error)")  // Логируем ошибку геокодирования
                self?.city = "Moscow"  // Устанавливаем значение по умолчанию при ошибке
                return
            }
            
            // Устанавливаем город, если геокодирование прошло успешно
            if let placemark = placemarks?.first, let city = placemark.locality {
                self?.city = city
            } else {
                self?.city = "Moscow"  // Если город не определился, устанавливаем по умолчанию
            }
        }
    }

    // Запрос погоды на один день по названию города
    func fetchWeatherOneDay(city: String) {
        guard let url = NetworkURL.weather(city: city).url else {
            print("Invalid URL")  // Логируем, если URL некорректен
            return
        }
        
        // Отправляем запрос на получение данных
        NetworkManager.shared.fetchData(from: url) { result in
            switch result {
            case .success(let data):
                do {
                    let decoder = JSONDecoder()
                    let response = try decoder.decode(WeatherOneDayModel.self, from: data)  // Декодируем данные в модель погоды
                    self.weather = response  // Сохраняем результат
                    self.onWeatherDataReceived?()  // Вызываем замыкание после получения данных
                } catch {
                    print("Error decoding data: \(error)")  // Логируем ошибку декодирования
                }
            case .failure(let error):
                print("Error network weather \(error)")  // Логируем ошибку сети
            }
        }
    }
    
    // Запрашиваем разрешение на доступ к местоположению, если поиск не по городу
    func requestLocationAuthorization() {
        if !isSearchByCity, didFetchLocationOnce {
            locationManager.requestWhenInUseAuthorization()  // Запрашиваем разрешение
            isSearchByCity = true  // Обновляем флаг, чтобы показывать, что сейчас идет поиск по городу
        }
    }
    
    // Запрос текущего местоположения для определения города
    func fetchCurrentLocation() {
        if !isSearchByCity {  // Проверяем, что поиск не по городу
            isSearchByCity = true  // Устанавливаем флаг, чтобы предотвратить повторные запросы
            didFetchLocationOnce = true
            locationManager.startUpdatingLocation()  // Запрашиваем обновление местоположения
        }
    }
}

extension WeatherViewModel: CLLocationManagerDelegate {
    // Вызывается при обновлении местоположения
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let location = locations.last else { return }
        fetchCityFromLocation(location)  // Получаем город на основе последних координат
    }
    
    // Вызывается в случае ошибки определения местоположения
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print("Location error: \(error)")  // Логируем ошибку
    }

    // Вызывается при изменении статуса авторизации для доступа к местоположению
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        switch status {
        case .authorizedWhenInUse, .authorizedAlways:
            locationManager.startUpdatingLocation()  // Начинаем обновление местоположения, если разрешение дано
        case .denied, .restricted, .notDetermined:
            print("Доступ к местоположению не разрешен или не определен")  // Логируем, если доступ запрещен или не определен
        @unknown default:
            break
        }
    }
}
