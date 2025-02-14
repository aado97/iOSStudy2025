//
//  ContentView.swift
//  SwiftDayUI03Ex02
//
//  Created by 도민준 on 2/12/25.
//

import SwiftUI

struct ContentView: View {
    
    @ViewBuilder
    func createContentView(_ showTitle: Bool) -> some View {
        if showTitle {
            Text("나의 앱")
                .font(.largeTitle)
        }
        
        Image(systemName: "globe")
            .imageScale(.large)
            .foregroundStyle(.tint)
        Text("Hello, World")
    }
    
    var body: some View {
        createContentView(false)
    }
}

#Preview {
    ContentView()
}
