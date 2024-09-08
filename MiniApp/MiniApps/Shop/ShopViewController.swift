//
//  ShopViewController.swift
//  MiniApp
//
//  Created by Алексей Гвоздков on 05.09.2024.
//

import UIKit

final class ShopViewController: UIViewController {
    weak var coordinator: CoordinatorVC?
    private let viewModel = ShopViewModelL()
    private let universalUIElements = UniversalUIElements()
    
    private lazy var lineView: UIView = {
        return universalUIElements.createLineView()
    }()
    
    private lazy var shopCollection: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.isScrollEnabled = true
        collectionView.backgroundColor = .lightText
        collectionView.dataSource = self
        collectionView.register(ShopGridCell.self, forCellWithReuseIdentifier: ShopGridCell.cellIdentifier)
        collectionView.delegate = self
        return collectionView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        settingsViewController()
        reloadDataCollection()
        viewModel.fetchData()
    }
    
    private func settingsViewController() {
        view.backgroundColor = .white
        
        view.addSubview(lineView)
        view.addSubview(shopCollection)
        
        NSLayoutConstraint.activate([
            lineView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
            lineView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            lineView.heightAnchor.constraint(equalToConstant: 5),
            lineView.widthAnchor.constraint(equalToConstant: 60),

            shopCollection.topAnchor.constraint(equalTo: lineView.bottomAnchor, constant: 10),
            shopCollection.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            shopCollection.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            shopCollection.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
    }
    
    private func reloadDataCollection() {
        viewModel.onDataLoaded = { [weak self] in
            DispatchQueue.main.async {
                self?.shopCollection.reloadData()
            }
        }
    }
}

// MARK: - extension UICollectionViewDataSource
extension ShopViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.products.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let identifier = ShopGridCell.cellIdentifier
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: identifier, for: indexPath)
        
        if let gridCell = cell as? ShopGridCell {
            let product = viewModel.products[indexPath.item]
            gridCell.cellUpdate(product: product)
            return gridCell
        }
        
        shopCollection.reloadData()
        return UICollectionViewCell()
    }
    
}

extension ShopViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let screenWidth = collectionView.frame.width
        let numberOfColumns: CGFloat = 2
        let interItemSpacing: CGFloat = 10
        let totalSpacing = (numberOfColumns - 1) * interItemSpacing
        let cellWidth = (screenWidth - totalSpacing) / numberOfColumns
        return CGSize(width: cellWidth, height: 278)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 5
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 5
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 10, left: 2, bottom: 10, right: 2) 
    }
}
