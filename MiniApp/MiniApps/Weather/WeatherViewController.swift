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
    
    private lazy var containerView1: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.layer.shadowColor = UIColor.gray.cgColor
        view.layer.shadowOpacity = 0.2
        view.layer.shadowOffset = CGSize(width: 4, height: 4)
        view.layer.shadowRadius = 8
        view.backgroundColor = .white
        view.layer.cornerRadius = 10
        return view
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
    
    private lazy var containerView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.layer.shadowColor = UIColor.gray.cgColor
        view.layer.shadowOpacity = 0.2
        view.layer.shadowOffset = CGSize(width: 4, height: 4)
        view.layer.shadowRadius = 8
        view.backgroundColor = .white
        view.layer.cornerRadius = 10
        return view
    }()
    
    private lazy var placeLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 19, weight: .ultraLight)
        return label
    }()
    
    private lazy var cityLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 32, weight: .bold)
        return label
    }()
    
    private lazy var temperatureLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 100, weight: .light)
        label.textColor = .systemBlue
        return label
    }()
    
    private lazy var degreeСelsiusLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 100, weight: .light)
        label.textColor = .systemBlue
        return label
    }()
    
    private lazy var feelsLikeLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 16, weight: .ultraLight)
        return label
    }()
    
    private lazy var windSpeedLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 16, weight: .ultraLight)
        return label
    }()
    
    private lazy var airPressureLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 16, weight: .ultraLight)
        return label
    }()
    
    private lazy var airHumidityLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 16, weight: .ultraLight)
        return label
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
        viewModel.fetchWeatherOneDay(city: viewModel.city)
    }
    
    private func settingsViewController() {
        view.addSubview(containerView1)
        containerView1.addSubview(searchBar)
        
        view.addSubview(containerView)
        containerView.addSubview(placeLabel)
        containerView.addSubview(cityLabel)
        containerView.addSubview(temperatureLabel)
        containerView.addSubview(degreeСelsiusLabel)
        containerView.addSubview(infoStack)
       
        NSLayoutConstraint.activate([
            containerView1.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 40),
            containerView1.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 40),
            containerView1.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -40),
            containerView1.heightAnchor.constraint(equalToConstant: 70),
            
            searchBar.centerYAnchor.constraint(equalTo: containerView1.centerYAnchor),
            searchBar.centerXAnchor.constraint(equalTo: containerView1.centerXAnchor),
            searchBar.leadingAnchor.constraint(equalTo: containerView1.leadingAnchor, constant: 0),
            searchBar.trailingAnchor.constraint(equalTo: containerView1.trailingAnchor, constant: 0),
            
            
            containerView.topAnchor.constraint(equalTo: containerView1.bottomAnchor, constant: 10),
            containerView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 40),
            containerView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -40),
            containerView.heightAnchor.constraint(equalToConstant: 400),
            
            placeLabel.topAnchor.constraint(equalTo: containerView.topAnchor, constant: 20),
            placeLabel.centerXAnchor.constraint(equalTo: containerView.centerXAnchor),
            
            cityLabel.topAnchor.constraint(equalTo: placeLabel.bottomAnchor, constant: 10),
            cityLabel.centerXAnchor.constraint(equalTo: containerView.centerXAnchor),
            
            temperatureLabel.topAnchor.constraint(equalTo: cityLabel.bottomAnchor, constant: 10),
            temperatureLabel.centerXAnchor.constraint(equalTo: containerView.centerXAnchor),
            
            degreeСelsiusLabel.topAnchor.constraint(equalTo: cityLabel.bottomAnchor, constant: 5),
            degreeСelsiusLabel.leadingAnchor.constraint(equalTo: temperatureLabel.trailingAnchor, constant: 5),
            
            infoStack.topAnchor.constraint(equalTo: temperatureLabel.bottomAnchor, constant: 20),
            infoStack.centerXAnchor.constraint(equalTo: containerView.centerXAnchor)
        ])
    }
    
    private func updateWeather() {
        placeLabel.text = "Текущее место"
        
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
    
    @objc private func hideKeyboard() {
        view.endEditing(true)
    }
}

extension WeatherViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        viewModel.fetchWeatherOneDay(city: searchText)
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
    }
}
