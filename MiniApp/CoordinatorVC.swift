//
//  CoordinatorVC.swift
//  MiniApp
//
//  Created by Алексей Гвоздков on 04.09.2024.
//

import UIKit

protocol Coordinating {
    var navigationController: UINavigationController? { get set }
    func start()
    func showWeatherViewController()
    func showMapViewController()
    func showShopViewController()
    func showGameViewController()
}

final class CoordinatorVC: Coordinating {
    var navigationController: UINavigationController?
    
    func start() {
        let miniAppsViewController = MiniAppsViewController()
        miniAppsViewController.coordinator = self
        navigationController?.pushViewController(miniAppsViewController, animated: true)
    }
    
    func showWeatherViewController() {
        let weatherViewController = WeatherViewController()
        weatherViewController.coordinator = self
        navigationController?.present(weatherViewController, animated: true)
    }   
    
    func showMapViewController() {
        let mapViewController = MapViewController()
        mapViewController.coordinator = self
        navigationController?.present(mapViewController, animated: true)
    }    
    
    func showShopViewController() {
        let shopViewController = ShopViewController()
        shopViewController.coordinator = self
        navigationController?.present(shopViewController, animated: true)
    }   
    
    func showGameViewController() {
        let gameViewController = GameViewController()
        gameViewController.coordinator = self
        navigationController?.present(gameViewController, animated: true)
    }
    
    
}

