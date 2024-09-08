//
//  CoutingsButtonsView.swift
//  MiniApp
//
//  Created by Алексей Гвоздков on 07.09.2024.
//

import UIKit

class CoutingsButtonsView: UIView {
    
    var productWeightText: String? {
        get {
            return productWeightLabel.text
        }
        set {
            productWeightLabel.text = newValue
        }
    }
    
    var priceLabelText: String? {
        get {
            return priceLabel.text
        }
        set {
            priceLabel.text = "~" + (newValue ?? "") + " ₽"
        }
    }
    
    var minusButtonAction: (() -> Void)?
    var plusButtonAction: (() -> Void)?
    
    private let universalUIElements = UniversalUIElements()
    
    private lazy var containerView: UIView = {
        let view = UIView()
        view.backgroundColor = .systemBlue
        view.layer.cornerRadius = 18
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private lazy var productWeightLabel: UILabel = {
        return universalUIElements.createLabel(fontSize: 15,
                                               weight: .bold,
                                               textColor: .white)
    }()
    
    private lazy var priceLabel: UILabel = {
        return universalUIElements.createLabel(fontSize: 13,
                                               weight: .semibold,
                                               textColor: .white.withAlphaComponent(0.8))
    }()
    
    private lazy var priceStack: UIStackView = {
        let stack = UIStackView(arrangedSubviews: [productWeightLabel, priceLabel])
        stack.axis = .vertical
        stack.alignment = .center
        stack.spacing = 2
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }()
    
    private lazy var minusButton: UIButton = {
        let imageButton = UIImage(named: "minusButton") ?? UIImage(systemName: "minus")?.withTintColor(UIColor.white)
        
        let button = UIButton()
        button.setImage(imageButton, for: .normal)
        button.addTarget(self, action: #selector(minusButtonTapped), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private lazy var plusButton: UIButton = {
        let imageButton = UIImage(named: "plusButton") ?? UIImage(systemName: "plus")?.withTintColor(UIColor.white)
        
        let button = UIButton()
        button.setImage(imageButton, for: .normal)
        button.addTarget(self, action: #selector(plusButtonTapped), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        constraintsSettingsView()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    func constraintsSettingsView() {
        addSubview(containerView)
        containerView.addSubview(priceStack)
        containerView.addSubview(minusButton)
        containerView.addSubview(plusButton)
        
        NSLayoutConstraint.activate([
            containerView.leadingAnchor.constraint(equalTo: leadingAnchor),
            containerView.trailingAnchor.constraint(equalTo: trailingAnchor),
            containerView.topAnchor.constraint(equalTo: topAnchor),
            containerView.bottomAnchor.constraint(equalTo: bottomAnchor),
            
            priceStack.centerXAnchor.constraint(equalTo: containerView.centerXAnchor),
            priceStack.topAnchor.constraint(equalTo: containerView.topAnchor, constant: 1),
            priceStack.bottomAnchor.constraint(equalTo: containerView.bottomAnchor, constant: -1),
            
            minusButton.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 10),
            minusButton.centerYAnchor.constraint(equalTo: containerView.centerYAnchor),
            minusButton.widthAnchor.constraint(equalToConstant: 16),
            minusButton.heightAnchor.constraint(equalToConstant: 16),
            
            plusButton.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -10),
            plusButton.centerYAnchor.constraint(equalTo: containerView.centerYAnchor),
            plusButton.widthAnchor.constraint(equalToConstant: 16),
            plusButton.heightAnchor.constraint(equalToConstant: 16)
        ])
    }
    
    @objc private func minusButtonTapped() {
        minusButtonAction?()
    }
    
    @objc private func plusButtonTapped() {
        plusButtonAction?()
    }
}

