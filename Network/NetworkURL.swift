//
//  NetworkURL.swift
//  MiniApp
//
//  Created by Алексей Гвоздков on 06.09.2024.
//

import Foundation

enum NetworkURL {
    case mocMiniApps
    
    var url: URL? {
        switch self {
        case .mocMiniApps:
            return URL(string: "https://run.mocky.io/v3/a61cc1d8-88cc-4770-b125-97a40322c470")
        }
    }
}
