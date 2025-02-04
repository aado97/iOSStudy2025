//
//  ContentView.swift
//  SwiftUITutorials
//
//  Created by 도민준 on 1/29/25.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        LandmarkList()
    }
}

#Preview {
    ContentView()
        .environment(ModelData())
}
