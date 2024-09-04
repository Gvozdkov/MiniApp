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
}

final class CoordinatorVC: Coordinating {
    var navigationController: UINavigationController?
    
    func start() {
        let miniAppsViewController = MiniAppsViewController()
        miniAppsViewController.coordinator = self
        navigationController?.pushViewController(miniAppsViewController, animated: true)
    }
}

