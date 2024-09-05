//
//  MiniAppsViewController.swift
//  MiniApp
//
//  Created by Алексей Гвоздков on 04.09.2024.
//

import UIKit

final class MiniAppsViewController: UIViewController {
    weak var coordinator: CoordinatorVC?
    private var viewModel = MiniAppsViewModel()
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 18, weight: .regular)
        label.textColor = .black
        label.text = "Mini apps"
        return label
    }()
    
    private lazy var miniAppsCollection: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.sectionInset = UIEdgeInsets(top: 10, left: 0, bottom: 10, right: 0)
        
        let collection = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collection.translatesAutoresizingMaskIntoConstraints = false
        collection.register(MiniAppsCell.self, forCellWithReuseIdentifier: MiniAppsCell.cellIdentifier)
        collection.delegate = self
        collection.dataSource = self
        return collection
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        settingsViewController()
        bindViewModel()
    }
    
    private func settingsViewController() {
        view.backgroundColor = .white
        view.addSubview(titleLabel)
        view.addSubview(miniAppsCollection)
        
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
            titleLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            
            miniAppsCollection.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            miniAppsCollection.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            miniAppsCollection.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 20),
            miniAppsCollection.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
        ])
    }
    private func bindViewModel() {
        viewModel.reloadData = { [weak self] in
            self?.miniAppsCollection.reloadData()
        }
    }
}

extension MiniAppsViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let screenWidth = view.bounds.width
        let screenHeight = view.bounds.height
        let itemHeight = screenHeight / 8
        let itemWidth = screenWidth
        
        return CGSize(width: itemWidth, height: itemHeight)
    }
}

extension MiniAppsViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.numberOfMiniApps()
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MiniAppsCell.cellIdentifier, for: indexPath) as? MiniAppsCell {
            let miniApp = viewModel.getMiniApp(at: indexPath.row)
              cell.configure(miniApp: miniApp)
            return cell
        } else {
            return UICollectionViewCell()
        }
    }
}

extension MiniAppsViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        switch indexPath.row {
        case 0:
            coordinator?.showWeatherViewController()
        case 1:
            coordinator?.showMapViewController()        
        case 2:
            coordinator?.showShopViewController()      
        case 3:
            coordinator?.showGameViewController()
        default:
            break
        }
    }
}
