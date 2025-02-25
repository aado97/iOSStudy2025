//
//  ContentView.swift
//  CombineSwiftUIEx
//
//  Created by 도민준 on 2/15/25.
//

import SwiftUI

struct Fruit: Identifiable {
    var id = UUID()      // 안정적이고 고유한 ID 생성
    var name: String
}


struct ContentView: View {
  @State private var items = ["사과", "바나나"]
  
  
  let fruits = [
    Fruit(name: "사과"),
    Fruit(name: "바나나"),
    Fruit(name: "오렌지")
  ]
  
  var body: some View {
//    List(fruits) { fruit in
//      Text(fruit.name)
//    }
//    
//    Button("항목 추가") {
//        items.append("오렌지")
//    }
    
//    List {
//        ForEach(items, id: \.self) { item in
//            Text(item)
//        }
//        .onDelete { indexSet in
//            items.remove(atOffsets: indexSet)
//        }
//    }
    
    List {
        ForEach(items, id: \.self) { item in
            Text(item)
        }
        .onMove { indices, newOffset in
            items.move(fromOffsets: indices, toOffset: newOffset)
        }
    }

  }
}

#Preview {
  ContentView()
}
