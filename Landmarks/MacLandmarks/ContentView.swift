//
//  ContentView.swift
//  MacLandmarks
//
//  Created by 도민준 on 2/9/25.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        LandmarkList()
            .frame(width: 700, height: 300)
    }
}

#Preview {
    ContentView()
        .environment(ModelData())
}
