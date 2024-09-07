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
        viewModel.requestLocationAuthorization()
        setupWeatherDataBinding()
        viewModel.fetchWeatherOneDay(city: viewModel.city)
    }
    
    private func settingsViewController() {
        view.addSubview(scrollView)
          scrollView.addSubview(contentView)
          
          contentView.addSubview(containerSearchBar)
          containerSearchBar.addSubview(searchBar)
          
          contentView.addSubview(containerView)
          containerView.addSubview(currentLocationButton)
          containerView.addSubview(cityLabel)
          containerView.addSubview(temperatureLabel)
          containerView.addSubview(degreeСelsiusLabel)
          containerView.addSubview(infoStack)
       
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
               
               containerSearchBar.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 40),
               containerSearchBar.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 40),
               containerSearchBar.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -40),
               containerSearchBar.heightAnchor.constraint(equalToConstant: 70),
               
               searchBar.centerYAnchor.constraint(equalTo: containerSearchBar.centerYAnchor),
               searchBar.leadingAnchor.constraint(equalTo: containerSearchBar.leadingAnchor),
               searchBar.trailingAnchor.constraint(equalTo: containerSearchBar.trailingAnchor),
               
               containerView.topAnchor.constraint(equalTo: containerSearchBar.bottomAnchor, constant: 10),
               containerView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 40),
               containerView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -40),
               containerView.heightAnchor.constraint(equalToConstant: 400),
               
               currentLocationButton.topAnchor.constraint(equalTo: containerView.topAnchor, constant: 20),
               currentLocationButton.heightAnchor.constraint(equalToConstant: 30),
               currentLocationButton.centerXAnchor.constraint(equalTo: containerView.centerXAnchor),
               
               cityLabel.topAnchor.constraint(equalTo: currentLocationButton.bottomAnchor, constant: 10),
               cityLabel.centerXAnchor.constraint(equalTo: containerView.centerXAnchor),
               
               temperatureLabel.topAnchor.constraint(equalTo: cityLabel.bottomAnchor, constant: 10),
               temperatureLabel.centerXAnchor.constraint(equalTo: containerView.centerXAnchor),
               
               degreeСelsiusLabel.topAnchor.constraint(equalTo: cityLabel.bottomAnchor, constant: 5),
               degreeСelsiusLabel.leadingAnchor.constraint(equalTo: temperatureLabel.trailingAnchor, constant: 5),
               
               infoStack.topAnchor.constraint(equalTo: temperatureLabel.bottomAnchor, constant: 20),
               infoStack.centerXAnchor.constraint(equalTo: containerView.centerXAnchor),
               
               infoStack.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -20)
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
        viewModel.fetchWeatherOneDay(city: viewModel.city)
        print("currentLocationButtonAction")
    }
    
    @objc private func hideKeyboard() {
        view.endEditing(true)
    }
}

extension WeatherViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        viewModel.isSearchByCity = true
        viewModel.fetchWeatherOneDay(city: searchText)
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
    }
}
