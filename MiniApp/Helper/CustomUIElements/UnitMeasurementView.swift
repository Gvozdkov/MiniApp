//
//  UnitMeasurementView.swift
//  MiniApp
//
//  Created by Алексей Гвоздков on 07.09.2024.
//

import UIKit

class UnitMeasurementView: UIView {
    private let universalUIElements = UniversalUIElements()
    
    private var unit: Int = 1 {
        didSet {
            updateUnitUI()
        }
    }
    
    var unitMeasurement: Int {
        get {
            return unit
        }
        set {
            unit = newValue
        }
    }
    
    private lazy var containerView: UIView = {
        let view = UIView()
        view.backgroundColor = Colors.lightGrayBackground
        view.clipsToBounds = true
        view.layer.cornerRadius = 8
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private lazy var piecesLabel: UILabel = {
        let label = universalUIElements.createLabel(fontSize: 14,
                                                    weight: .regular,
                                                    textColor: .black)
        label.clipsToBounds = true
        label.layer.cornerRadius = 8
        label.text = "Шт"
        label.textAlignment = .center
        return label
    }()
    
    private lazy var kilogramsLabel: UILabel = {
        let label = universalUIElements.createLabel(fontSize: 14,
                                                    weight: .regular,
                                                    textColor: .black)
        label.clipsToBounds = true
        label.layer.cornerRadius = 8
        label.text = "Кг"
        label.textAlignment = .center
        return label
    }()
    
    private lazy var labelStack: UIStackView = {
        let stack = UIStackView(arrangedSubviews: [piecesLabel, kilogramsLabel])
        stack.axis = .horizontal
        stack.distribution = .fillEqually
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        constraintsSettingsView()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    private func constraintsSettingsView() {
        addSubview(containerView)
        containerView.addSubview(labelStack)
        
        NSLayoutConstraint.activate([
            containerView.leadingAnchor.constraint(equalTo: leadingAnchor),
            containerView.trailingAnchor.constraint(equalTo: trailingAnchor),
            containerView.topAnchor.constraint(equalTo: topAnchor),
            containerView.bottomAnchor.constraint(equalTo: bottomAnchor),
            
            labelStack.centerXAnchor.constraint(equalTo: containerView.centerXAnchor),
            labelStack.centerYAnchor.constraint(equalTo: containerView.centerYAnchor),
            
            piecesLabel.topAnchor.constraint(equalTo: containerView.topAnchor, constant: 2),
            piecesLabel.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 2),
            piecesLabel.bottomAnchor.constraint(equalTo: containerView.bottomAnchor, constant: -2),
            
            kilogramsLabel.topAnchor.constraint(equalTo: containerView.topAnchor, constant: 2),
            kilogramsLabel.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -2),
            kilogramsLabel.bottomAnchor.constraint(equalTo: containerView.bottomAnchor, constant: -2),
        ])
    }
    
    private func updateUnitUI() {
        piecesLabel.backgroundColor = unit == 1 ? .white : .clear
        piecesLabel.textColor = unit == 1 ? .black : Colors.grayBackground
        
        kilogramsLabel.backgroundColor = unit == 1 ? .clear : .white
        kilogramsLabel.textColor = unit == 1 ? Colors.grayBackground : .black
    }
}

