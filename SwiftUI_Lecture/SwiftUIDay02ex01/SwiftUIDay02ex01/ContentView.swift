//
//  ContentView.swift
//  SwiftUIDay02ex01
//
//  Created by 도민준 on 2/11/25.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        VStack {
            Image(systemName: "globe")
                .imageScale(.large)
                .foregroundStyle(.tint)
            Text("SwiftUI 실습")
                .font(.largeTitle)
                .foregroundColor(.red)
                .background(Color.yellow)
                .overlay(
                    RoundedRectangle(cornerRadius: 10)
                        .stroke(.blue)
                )
        }
        .padding()
    }
}

#Preview {
    ContentView()
}
