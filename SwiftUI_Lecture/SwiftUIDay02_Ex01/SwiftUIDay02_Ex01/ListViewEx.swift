//
//  ListViewEx.swift
//  SwiftUIDay02_Ex01
//
//  Created by 도민준 on 2/11/25.
//

/*
 **문제 설명:**
 
 `List`와 `ForEach`를 사용해 **문자열 배열**에 있는 단어들을 **리스트 형식으로 출력**하세요.
 
 **배열:**
 
 ```swift
 let fruits = ["Apple", "Banana", "Cherry", "Mango"]
 ```
 
 **조건:**
 
 - `List`와 `ForEach`를 조합해 배열 요소를 하나씩 출력
 - 각 단어는 **글자 크기를 title**, **텍스트 색상은 초록색**으로 설정
 */

import SwiftUI

struct FruitDetailView: View {
    var fruit: String
    
    var body: some View {
        Text("\(fruit) 상세 페이지")
            .font(.title)
        Text("전달 받은 과일은 \(fruit)입니다.")
    }
}

struct ListViewEx: View {
    let fruits = ["Apple", "Banana", "Cherry", "Mango"]
    
    var body: some View {
        NavigationView {
            List (fruits, id: \.self){ fruit in
                NavigationLink(destination: FruitDetailView(fruit: fruit)) {
                    Text(fruit).padding()
                }
            }
        }
        .navigationTitle("이스트 과일 쥬스")
    }
}

#Preview {
    ListViewEx()
}
