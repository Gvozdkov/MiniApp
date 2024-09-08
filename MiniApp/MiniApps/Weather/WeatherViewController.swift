//
//  WeatherViewController.swift
//  MiniApp
//
//  Created by Алексей Гвоздков on 05.09.2024.
//

import UIKit

final class WeatherViewController: UIViewController {
    weak var coordinator: CoordinatorVC?
    private var viewModel = WeatherViewModel()
    private let universalUIElements = UniversalUIElements()
    
    private lazy var lineView: UIView = {
        return universalUIElements.createLineView()
    }()
    
    private lazy var scrollView: UIScrollView = {
        let scroll = UIScrollView()
        scroll.translatesAutoresizingMaskIntoConstraints = false
        return scroll
    }()
    
    private lazy var contentView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private lazy var containerSearchBar: UIView = {
        return universalUIElements.createShadowContainerView()
    }()
    
    private lazy var searchBar: UISearchBar = {
        let text = "Выбери город"
        let searchBar = UISearchBar()
        searchBar.translatesAutoresizingMaskIntoConstraints = false
        searchBar.backgroundImage = UIImage()
        searchBar.isTranslucent = false
        searchBar.placeholder = text
        searchBar.delegate = self
        return searchBar
    }()
    
    private lazy var containerViewTemperature: UIView = {
        return universalUIElements.createShadowContainerView()
    }()
    
    private lazy var currentLocationButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.titleLabel?.font = UIFont.systemFont(ofSize: 19)
        button.setTitleColor(.lightGray, for: .normal)
        button.setTitle("Текущее место", for: .normal)
        button.backgroundColor = .clear
        
        button.addTarget(self, action: #selector(currentLocationButtonAction), for: .touchUpInside)
        return button
    }()
    
    private lazy var cityLabel: UILabel = {
        return universalUIElements.createLabel(fontSize: 32,
                                               weight: .bold,
                                               textColor: .black)
    }()
    
    private lazy var temperatureLabel: UILabel = {
        return universalUIElements.createLabel(fontSize: 100,
                                               weight: .light,
                                               textColor: .systemBlue)
    }()
    
    private lazy var degreeСelsiusLabel: UILabel = {
        return universalUIElements.createLabel(fontSize: 100,
                                               weight: .light,
                                               textColor: .systemBlue)
    }()
    
    private lazy var containerViewWeatherDetails: UIView = {
        return universalUIElements.createShadowContainerView()
    }()
    
    private lazy var feelsLikeLabel: UILabel = {
        return universalUIElements.createLabel(fontSize: 16,
                                               weight: .ultraLight,
                                               textColor: .black)
    }()
    
    private lazy var windSpeedLabel: UILabel = {
        return universalUIElements.createLabel(fontSize: 16,
                                               weight: .ultraLight,
                                               textColor: .black)
    }()
    
    private lazy var airPressureLabel: UILabel = {
        return universalUIElements.createLabel(fontSize: 16,
                                               weight: .ultraLight,
                                               textColor: .black)
    }()
    
    private lazy var airHumidityLabel: UILabel = {
        return universalUIElements.createLabel(fontSize: 16,
                                               weight: .ultraLight,
                                               textColor: .black)
    }()
    
    private lazy var infoStack: UIStackView = {
        let stack = UIStackView(arrangedSubviews: [feelsLikeLabel, airPressureLabel, airHumidityLabel, windSpeedLabel])
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.axis = .vertical
        stack.alignment = .center
        stack.spacing = 5
        return stack
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        settingsViewController()
        setupTapGestureToHideKeyboard()
        setupWeatherDataBinding()
    }
    
    private func settingsViewController() {
        view.addSubview(scrollView)
        scrollView.addSubview(contentView)
        contentView.addSubview(lineView)
        contentView.addSubview(containerSearchBar)
        contentView.addSubview(containerViewTemperature)
        contentView.addSubview(containerViewWeatherDetails)
        
        containerSearchBar.addSubview(searchBar)
        containerViewTemperature.addSubview(currentLocationButton)
        containerViewTemperature.addSubview(cityLabel)
        containerViewTemperature.addSubview(temperatureLabel)
        containerViewTemperature.addSubview(degreeСelsiusLabel)
        containerViewWeatherDetails.addSubview(infoStack)
        
        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            
            contentView.topAnchor.constraint(equalTo: scrollView.topAnchor),
            contentView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            contentView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
            contentView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
            contentView.widthAnchor.constraint(equalTo: scrollView.widthAnchor),
            contentView.heightAnchor.constraint(greaterThanOrEqualTo: scrollView.heightAnchor, constant: 140),
            
            lineView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 20),
            lineView.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            lineView.heightAnchor.constraint(equalToConstant: 5),
            lineView.widthAnchor.constraint(equalToConstant: 60),
            
            containerSearchBar.topAnchor.constraint(equalTo: lineView.bottomAnchor, constant: 20),
            containerSearchBar.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            containerSearchBar.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20),
            containerSearchBar.heightAnchor.constraint(equalToConstant: 70),
            
            searchBar.centerYAnchor.constraint(equalTo: containerSearchBar.centerYAnchor),
            searchBar.leadingAnchor.constraint(equalTo: containerSearchBar.leadingAnchor),
            searchBar.trailingAnchor.constraint(equalTo: containerSearchBar.trailingAnchor),
            
            containerViewTemperature.topAnchor.constraint(equalTo: containerSearchBar.bottomAnchor, constant: 10),
            containerViewTemperature.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            containerViewTemperature.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20),
            containerViewTemperature.heightAnchor.constraint(equalToConstant: 260),
            
            currentLocationButton.topAnchor.constraint(equalTo: containerViewTemperature.topAnchor, constant: 20),
            currentLocationButton.centerXAnchor.constraint(equalTo: containerViewTemperature.centerXAnchor),
            currentLocationButton.heightAnchor.constraint(equalToConstant: 40),
            
            cityLabel.topAnchor.constraint(equalTo: currentLocationButton.bottomAnchor, constant: 10),
            cityLabel.centerXAnchor.constraint(equalTo: containerViewTemperature.centerXAnchor),
            
            temperatureLabel.topAnchor.constraint(equalTo: cityLabel.bottomAnchor, constant: 10),
            temperatureLabel.centerXAnchor.constraint(equalTo: containerViewTemperature.centerXAnchor),
            
            degreeСelsiusLabel.centerYAnchor.constraint(equalTo: temperatureLabel.centerYAnchor),
            degreeСelsiusLabel.leadingAnchor.constraint(equalTo: temperatureLabel.trailingAnchor, constant: 5),
            
            containerViewWeatherDetails.topAnchor.constraint(equalTo: containerViewTemperature.bottomAnchor, constant: 10),
            containerViewWeatherDetails.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            containerViewWeatherDetails.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20),
            containerViewWeatherDetails.heightAnchor.constraint(equalToConstant: 140),
            
            infoStack.centerYAnchor.constraint(equalTo: containerViewWeatherDetails.centerYAnchor),
            infoStack.centerXAnchor.constraint(equalTo: containerViewWeatherDetails.centerXAnchor)
        ])
    }
    
    private func updateWeather() {
        if let city = viewModel.weather?.name {
            cityLabel.text = city
        } else {
            cityLabel.text = "--"
        }
        
        if let temp = viewModel.weather?.main.temp {
            temperatureLabel.text = String(format: "%.1f", temp)
        } else {
            temperatureLabel.text = "--"
        }
        
        degreeСelsiusLabel.text =  "°"
        
        if let feelsLike = viewModel.weather?.main.feels_like {
            feelsLikeLabel.text = "Ощущается как \(String(format: "%.1f", feelsLike))"
        } else {
            feelsLikeLabel.text = "--"
        }
        
        if let windSpeed = viewModel.weather?.wind.speed {
            windSpeedLabel.text = "Скорость ветра \(windSpeed) м/с"
        } else {
            windSpeedLabel.text = "--"
        }
        
        if let airPressure = viewModel.weather?.main.pressure {
            airPressureLabel.text = "Давление воздуха \(airPressure) гПа"
        } else {
            airPressureLabel.text = "--"
        }
        
        if let airHumidity = viewModel.weather?.main.humidity {
            airHumidityLabel.text = "Влажность воздуха \(airHumidity)%"
        } else {
            airHumidityLabel.text = "--"
        }
    }
    
    private func setupTapGestureToHideKeyboard() {
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(hideKeyboard))
        view.addGestureRecognizer(tapGesture)
    }
    
    private func setupWeatherDataBinding() {
        viewModel.onWeatherDataReceived = { [weak self] in
            DispatchQueue.main.async {
                self?.updateWeather()
            }
        }
    }
    
    @objc private func currentLocationButtonAction() {
        searchBar.text = nil
        hideKeyboard()
        viewModel.isSearchByCity = false
        viewModel.fetchCurrentLocation()
    }
    
    @objc private func hideKeyboard() {
        viewModel.isSearchByCity = true
        view.endEditing(true)
    }
}

extension WeatherViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        viewModel.isSearchByCity = true
        viewModel.fetchWeatherOneDay(city: searchText)
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        viewModel.isSearchByCity = true
        searchBar.resignFirstResponder()
    }
}
