//
//  CounterView.swift
//  CombineSwiftUIEx
//
//  Created by 도민준 on 2/15/25.
//

import SwiftUI
import Combine

class CounterModel: ObservableObject {
    @Published var count = 0
}

struct CounterView: View {
    @StateObject private var model = CounterModel()

    var body: some View {
        VStack {
            Text("Count: \(model.count)")
                .font(.largeTitle)
            Button("Increase") {
                model.count += 1
            }
            .padding()
            .background(Color.blue)
            .foregroundColor(.white)
            .cornerRadius(10)
        }
    }
}

#Preview {
    CounterView()
}
