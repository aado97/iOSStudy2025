//
//  Product.swift
//  SwiftUIDay02ShopStep01
//
//  Created by 도민준 on 2/11/25.
//

import Foundation

struct Product: Identifiable, Codable {
    var id: UUID = UUID()  // 자동 생성
    var name: String
    var imageName: String
    var price: Int
    var description: String
    var isFavorite: Bool

    // JSON에서 `id` 필드가 없어도 `UUID()`를 기본값으로 사용하도록 함
    private enum CodingKeys: String, CodingKey {
        case name, imageName, price, description, isFavorite
    }
}
