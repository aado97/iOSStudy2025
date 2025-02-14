//
//  ContentView.swift
//  SwiftUIDay04Ex03DatePicker
//
//  Created by 도민준 on 2/13/25.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        VStack {
            Image(systemName: "globe")
                .imageScale(.large)
                .foregroundStyle(.tint)
            Text("Hello, world!")
            
            TextFieldExample()
            
            Text("우선순위 낮음")
                .layoutPriority(0)
            Text("우선순위 높음")
                .layoutPriority(1)

        }
        .padding()
    }
}

#Preview {
    ContentView()
}
