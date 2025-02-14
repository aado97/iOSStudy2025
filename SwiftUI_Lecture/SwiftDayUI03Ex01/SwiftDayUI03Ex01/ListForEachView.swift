//
//  ListForEachView.swift
//  SwiftDayUI03Ex01
//
//  Created by 도민준 on 2/12/25.
//

import SwiftUI

struct Fruit: Identifiable {
    var id = UUID()
    var name: String
}

struct ListForEachView: View {
    let fruits = [
        Fruit(name: "Apple"),
        Fruit(name: "Banana"),
        Fruit(name: "Cherry"),
        Fruit(name: "Mango")
    ]
    
    var body: some View {
        List {
            ForEach(fruits) { fruit in
                Text(fruit.name)
                    .font(.title)
                    .foregroundColor(.green)
            }
        }
        .navigationTitle("과일 목록")
    }
}

#Preview {
    NavigationView {
        ListForEachView()
    }
}
