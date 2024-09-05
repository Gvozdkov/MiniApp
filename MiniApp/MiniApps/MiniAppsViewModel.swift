//
//  MiniAppsViewModel.swift
//  MiniApp
//
//  Created by Алексей Гвоздков on 05.09.2024.
//

import Foundation

final class MiniAppsViewModel {
    
    private var miniApps: [MiniAppsModel] = []
    
    var reloadData: (() -> Void)?
    
    init() {
        fetchMiniApps()
    }

    private func fetchMiniApps() {
        guard let url = NetworkURL.mocMiniApps.url else {
            print("Invalid URL")
            return
        }
        
        NetworkManager.shared.fatchData(from: url) { result in
            switch result {
            case .success(let data):
                do {
                    let decoder = JSONDecoder()
                    let response = try decoder.decode([String: [MiniAppsModel]].self, from: data)
                    if let miniApp = response["miniApps"] {
                        self.miniApps = miniApp
                        self.reloadData?()
                    }
                } catch {
                    print("Error decoding data: \(error)")
                }
            case .failure(let error):
                print("Error network airRecommendationFeed \(error)")
            }
        }
    }
    
    func getMiniApp(at index: Int) -> MiniAppsModel {
        return miniApps[index]
    }
    
    func numberOfMiniApps() -> Int {
        return miniApps.count
    }
}

