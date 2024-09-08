//
//  CartButtonView.swift
//  MiniApp
//
//  Created by Алексей Гвоздков on 07.09.2024.
//

import UIKit

class CartButtonView: UIButton {
    var cartButtonAction: (() -> Void)?
    
    private lazy var cartButton: UIButton = {
        let button = UIButton()
        button.layer.cornerRadius = 18
        button.backgroundColor = .systemBlue
        button.addTarget(self, action: #selector(cartButtonTapped), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private lazy var cartImage: UIImageView = {
        let image = UIImageView()
        image.image = UIImage(named: "cart") ?? UIImage(systemName: "cart.fill")
        image.contentMode = .scaleAspectFit
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        constraintsSettingsView()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
   
    private func constraintsSettingsView() {
        addSubview(cartButton)
        cartButton.addSubview(cartImage)
        
        NSLayoutConstraint.activate([
            cartButton.widthAnchor.constraint(equalToConstant: 48),
            cartButton.heightAnchor.constraint(equalToConstant: 36),
            
            cartImage.centerXAnchor.constraint(equalTo: cartButton.centerXAnchor),
            cartImage.centerYAnchor.constraint(equalTo: cartButton.centerYAnchor)
        ])
    }
    
    @objc private func cartButtonTapped() {
        cartButtonAction?()
    }
}
