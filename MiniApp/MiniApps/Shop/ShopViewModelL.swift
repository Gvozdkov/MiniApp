//
//  ShopViewModelL.swift
//  MiniApp
//
//  Created by Алексей Гвоздков on 07.09.2024.
//

import Foundation

final class ShopViewModelL {
    private(set) var products = [ShopProductModel]()
    private(set) var cellSwitch = true
    var onDataLoaded: (() -> Void)?
    
    func fetchData() {
        guard let url = NetworkURL.shop.url else {
            print("Invalide url")
            return
        }
        
        NetworkManager.shared.fetchData(from: url) { result in
            switch result {
            case .success(let data):
                do {
                    let decoder = JSONDecoder()
                    let mokProducts = try decoder.decode([ShopProductModel].self, from: data)
                    self.products = mokProducts
                    DispatchQueue.main.async {
                        self.onDataLoaded?()
                    }
                } catch {
                    print("Error decoding data: \(error)")
                }
                
            case .failure(let error):
                print("Error network ShopProduct \(error)")
            }
        }
    }
    
    func toggleButtonCollectionImage() -> String {
        if cellSwitch {
            return "buttonCollectionOne"
        } else {
            return "buttonCollectionTwo"
        }
    }
    
    func toggleCellSwitch() {
        cellSwitch.toggle()
        onDataLoaded?()
    }
}


