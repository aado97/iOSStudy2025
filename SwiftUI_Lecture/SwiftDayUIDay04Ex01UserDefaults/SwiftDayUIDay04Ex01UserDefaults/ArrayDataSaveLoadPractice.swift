//
//  ArrayDataSaveLoadPractice.swift
//  SwiftDayUIDay04Ex01UserDefaults
//
//  Created by 도민준 on 2/13/25.
//

import SwiftUI

struct ArrayDataSaveLoadPractice: View {
    @State private var fruits: [String] = []    // 불러올 데이터를 저장할 배열
    
    var body: some View {
        VStack(spacing: 20) {
            Button("저장하기") {
                let favoriteFruits = ["Apple", "Banana", "Cherry"]
                UserDefaults.standard.set(favoriteFruits, forKey: "favoriteFruits")
                print("저장된 과일: \(favoriteFruits)")
            }
            
            Button("불러오기") {
                if let loadedFruits = UserDefaults.standard.array(forKey: "favoriteFruits") as? [String] {
                    fruits = loadedFruits
                    print("불러온 과일: \(loadedFruits)")
                } else {
                    print("저장된 데이터가 없습니다.")
                }
            }
            
            Text("불러온 과일: \(fruits.joined(separator: ", "))")
                .padding()
        }
        .padding()
    }
}

#Preview {
    ArrayDataSaveLoadPractice()
}
