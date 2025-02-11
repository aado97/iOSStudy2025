//
//  ContentView.swift
//  SwiftUIDay02_Ex01
//
//  Created by 도민준 on 2/11/25.
//

import SwiftUI
import UIKit

struct Product: Decodable {
    let name: String
    let imageName: String
    let price: Int
    let description: String
    let isFavorite: Bool
}

struct ContentView: View {
    @State var count = 0
    var body: some View {
        VStack {
            StyleTextView()
            Image(systemName: "globe")
                .imageScale(.large)
                .foregroundStyle(.tint)
            Text("Hello, world!")
        }
        .padding()
        
        Button("확인") {
            test()
            test2()
        }
    }
    
    func test2() {
        count += 1
        print(count)
    }
    
    func test() {
        print("JSON 데이터 변환 예제")
        let jsonString = """
        [
          {
            "name": "나는야 무화과",
            "imageName": "fig",
            "price": 3100,
            "description": "소화가 잘되고 변비에 좋은 달달한 국내산 무화과에요. 고기와 찰떡궁합!",
            "isFavorite": false
          },
          {
            "name": "유기농 아보카도",
            "imageName": "avocado",
            "price": 2900,
            "description": "미네랄도 풍부하고, 요리 장식과 소스로도 좋은 아보카도입니다",
            "isFavorite": false
          },
          {
            "name": "바나나 안 바나나",
            "imageName": "banana",
            "price": 2400,
            "description": "달콤한 맛의 바나나. 이렇게 맛있으니 내가 바나나 안 바나나?",
            "isFavorite": true
          }
        ]
        """
        
        if let jsonData = jsonString.data(using: .utf8) {
            do {
                let products = try JSONDecoder().decode([Product].self, from: jsonData)
                for product in products {
                    let productDict: [String: Any] = [
                        "name": product.name,
                        "imageName": product.imageName,
                        "price": product.price,
                        "description": product.description,
                        "isFavorite": product.isFavorite
                    ]
                    print(productDict)
                }
            } catch {
                print("❌ JSON 디코딩 오류: \(error.localizedDescription)")
            }
        }
    }
}

#Preview {
    ContentView()
}
