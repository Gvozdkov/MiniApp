//
//  ShopProductModel.swift
//  MiniApp
//
//  Created by Алексей Гвоздков on 07.09.2024.
//

import Foundation

struct ShopProductModel: Decodable {
    let id: Int
    let name: String
    let countryOrigin: Int
    let photo: String
    let rating: Float
    let comments: Int
    let discountedPrice: Float
    let oldPrice: Float
    let unitMeasurement: Int
    let discount: Int
    let promotionalProduct: Int
}
