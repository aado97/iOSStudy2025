//
//  ProductDataLoader.swift
//  SwiftUIDay02ShopStep01
//
//  Created by 도민준 on 2/11/25.
//

import Foundation

class ProductDataLoader: ObservableObject {
    @Published var products: [Product] = []

    init() {
        loadProducts()
    }

    func loadProducts() {
        guard let url = Bundle.main.url(forResource: "ProductData", withExtension: "json") else {
            print("❌ [Error] ProductData.json 파일을 찾을 수 없습니다. 번들에 포함되었는지 확인하세요.")
            return
        }

        do {
            let data = try Data(contentsOf: url)
            let decoder = JSONDecoder()
            decoder.keyDecodingStrategy = .convertFromSnakeCase // snake_case -> camelCase 자동 변환
            let decodedProducts = try decoder.decode([Product].self, from: data)

            DispatchQueue.main.async {
                self.products = decodedProducts
            }
        } catch let DecodingError.dataCorrupted(context) {
            print("❌ [Error] 데이터 손상: \(context)")
        } catch let DecodingError.keyNotFound(key, context) {
            print("❌ [Error] 키 없음: \(key) - \(context.debugDescription)")
        } catch let DecodingError.typeMismatch(type, context) {
            print("❌ [Error] 타입 불일치: \(type) - \(context.debugDescription)")
        } catch let DecodingError.valueNotFound(type, context) {
            print("❌ [Error] 값 없음: \(type) - \(context.debugDescription)")
        } catch {
            print("❌ [Error] JSON 로드 실패: \(error.localizedDescription)")
        }
    }
}
