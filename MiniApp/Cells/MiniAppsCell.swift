//
//  MiniAppsCell.swift
//  MiniApp
//
//  Created by Алексей Гвоздков on 04.09.2024.
//

import UIKit

final class MiniAppsCell: UICollectionViewCell {
    static let cellIdentifier = "MiniAppsCell"
    
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
    
    private lazy var appImage: UIImageView = {
        let image = UIImageView()
        image.contentMode = .scaleAspectFit
        image.translatesAutoresizingMaskIntoConstraints = false
        image.clipsToBounds = true
        image.layer.cornerRadius = 8
        return image
    }()
    
    private lazy var nameLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 12, weight: .light)
        label.textColor = .black
        return label
    }()
    
    private lazy var descriptionLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 12, weight: .ultraLight)
        label.textColor = .black
        label.numberOfLines = 2
        return label

    }()
    
    private lazy var labelStack: UIStackView = {
        let stack = UIStackView(arrangedSubviews: [nameLabel, descriptionLabel])
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.axis = .vertical
        stack.spacing = 0
        stack.distribution = .fillProportionally
        return stack
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        constraintsSettingsView()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        assertionFailure("init(coder:) has not been implemented")
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
    }
    
    private func constraintsSettingsView() {
        contentView.addSubview(containerView)
        containerView.addSubview(appImage)
        containerView.addSubview(labelStack)
        
        NSLayoutConstraint.activate([
            containerView.topAnchor.constraint(equalTo: topAnchor),
            containerView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            containerView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20),
            containerView.bottomAnchor.constraint(equalTo: bottomAnchor),
            
            appImage.topAnchor.constraint(equalTo: containerView.topAnchor, constant: 10),
            appImage.bottomAnchor.constraint(equalTo: containerView.bottomAnchor, constant: -10),
            appImage.widthAnchor.constraint(equalTo: appImage.heightAnchor),
            appImage.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 20),
            
            labelStack.leadingAnchor.constraint(equalTo: appImage.trailingAnchor, constant: 20),
            labelStack.topAnchor.constraint(equalTo: appImage.topAnchor, constant: 0),
            labelStack.bottomAnchor.constraint(equalTo: appImage.bottomAnchor, constant: 0),
            labelStack.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -20),
        ])
    }
    
    func configure(miniApp: MiniAppsModel) {
        appImage.image = UIImage(systemName: miniApp.image)
        nameLabel.text = miniApp.name
        descriptionLabel.text = miniApp.description
    }
}
