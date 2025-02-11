//
//  ProductDetailView.swift
//  SwiftUIDay02ShopStep01
//
//  Created by 도민준 on 2/11/25.
//

import SwiftUI

struct ProductDetailView: View {
    var product: Product

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 20) {
                Image(product.imageName)
                    .resizable()
                    .scaledToFit()
                    .frame(height: 300)
                    .cornerRadius(15)
                    .shadow(radius: 5)

                Text(product.name)
                    .font(.title)
                    .fontWeight(.bold)

                Text("₩\(product.price)")
                    .font(.headline)
                    .foregroundColor(.green)

                Text(product.description)
                    .font(.body)
                    .foregroundColor(.gray)

                HStack {
                    Spacer()
                    Button(action: {
                        print("\(product.name) 구매 버튼 클릭됨!")
                    }) {
                        Text("구매하기")
                            .bold()
                            .frame(maxWidth: .infinity)
                            .padding()
                            .background(Color.blue)
                            .foregroundColor(.white)
                            .cornerRadius(10)
                    }
                    Spacer()
                }
                .padding(.top, 20)
            }
            .padding()
        }
        .navigationTitle("상품 상세")
    }
}

#Preview {
    ProductDetailView(product: Product(
        name: "바나나 안 바나나",
        imageName: "banana",
        price: 2400,
        description: "달콤한 맛의 바나나. 이렇게 맛있으니 내가 바나나 안 바나나?",
        isFavorite: true
    ))
}
