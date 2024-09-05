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
        miniApps = [
            MiniAppsModel(image: "smoke.circle.fill", name: "Погода", description: "Следите за погодой в реальном времени."),
            MiniAppsModel(image: "mappin.and.ellipse", name: "Местоположение", description: "Определите своё местоположение."),
            MiniAppsModel(image: "cart.fill", name: "Магазин", description: "Список покупок всегда под рукой."),
            MiniAppsModel(image: "gamecontroller", name: "Игры", description: "Время для игр.")
        ]
        reloadData?()
    }
    
    func getMiniApp(at index: Int) -> MiniAppsModel {
        return miniApps[index]
    }
    
    func numberOfMiniApps() -> Int {
        return miniApps.count
    }
}
