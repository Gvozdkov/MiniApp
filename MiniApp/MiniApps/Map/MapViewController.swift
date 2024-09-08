//
//  MapViewController.swift
//  MiniApp
//
//  Created by Алексей Гвоздков on 05.09.2024.
//

import UIKit
import WebKit

final class MapViewController: UIViewController {
    weak var coordinator: CoordinatorVC?
    private let universalUIElements = UniversalUIElements()
    
    private lazy var lineView: UIView = {
        return universalUIElements.createLineView()
    }()
    
    private lazy var webView: WKWebView = {
        let web = WKWebView()
        web.translatesAutoresizingMaskIntoConstraints = false
        web.clipsToBounds = true
        web.layer.cornerRadius = 14
        return web
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        settingsViewController()
        urlWebView()
    }
    
    private func settingsViewController() {
        view.backgroundColor = .white
        
        view.addSubview(lineView)
        view.addSubview(webView)
        
        NSLayoutConstraint.activate([
            lineView.topAnchor.constraint(equalTo: view.topAnchor, constant: 20),
            lineView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            lineView.heightAnchor.constraint(equalToConstant: 5),
            lineView.widthAnchor.constraint(equalToConstant: 60),
            
            webView.topAnchor.constraint(equalTo: lineView.bottomAnchor, constant: 10),
            webView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            webView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            webView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
    
    private func urlWebView() {
        guard let url = NetworkURL.map.url else {
            print("Invalid URL")
            return
        }
        
        let request = URLRequest(url: url)
        webView.load(request)
    }
}

