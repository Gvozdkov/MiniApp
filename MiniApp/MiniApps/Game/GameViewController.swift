//
//  GameViewController.swift
//  MiniApp
//
//  Created by Алексей Гвоздков on 05.09.2024.
//

import UIKit

final class GameViewController: UIViewController {
    weak var coordinator: CoordinatorVC?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .black
    }
}
