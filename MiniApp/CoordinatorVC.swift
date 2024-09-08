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
        
        if let sheet = weatherViewController.sheetPresentationController {
            sheet.detents = [.medium(), .large()]
            sheet.preferredCornerRadius = 20
        }
        
        navigationController?.present(weatherViewController, animated: true)
    }   
    
    func showMapViewController() {
        let mapViewController = MapViewController()
        mapViewController.coordinator = self
        mapViewController.modalPresentationStyle = .pageSheet
        
        if let sheet = mapViewController.sheetPresentationController {
            sheet.detents = [.medium(), .large()]
            sheet.preferredCornerRadius = 20
        }
        
        navigationController?.present(mapViewController, animated: true)
    }
    
    func showShopViewController() {
        let shopViewController = ShopViewController()
        shopViewController.coordinator = self
        shopViewController.modalPresentationStyle = .pageSheet
        
        if let sheet = shopViewController.sheetPresentationController {
            sheet.detents = [.medium(), .large()]
            sheet.preferredCornerRadius = 20
        }
        
        navigationController?.present(shopViewController, animated: true)
    }
}

