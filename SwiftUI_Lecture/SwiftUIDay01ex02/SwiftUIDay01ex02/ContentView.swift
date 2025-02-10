//
//  ContentView.swift
//  SwiftUIDay01ex02
//
//  Created by 도민준 on 2/10/25.
//

import SwiftUI

struct CustomButton: View {
    var title: String
    var action: () -> Void
    var body: some View {
        Button(title) {
            action()
        }
    }
}

struct ContentView: View {
    var body: some View {
        CustomButton(title: "Click Me") {
            print("Hello world!")
        }
        Text("Placeholder")
            .font(.title)
            .multilineTextAlignment(.center)
            .padding()
        Button("클릭!") {
            print("클릭했습니다.")
        }
        .padding(.horizontal, 0.0)
    }
}

#Preview {
    ContentView()
}
