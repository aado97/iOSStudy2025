//
//  SheetView.swift
//  0224_SwiftUI_EX
//
//  Created by 도민준 on 2/24/25.
//

import SwiftUI

struct SheetView: View {
    @State private var showModal = false

    var body: some View {
        Button("Show Modal") {
            showModal = true
        }
        .sheet(isPresented: $showModal) {
            Text("This is a modal view")
                .presentationDetents([.medium, .large])
        }
    }
}

#Preview {
    SheetView()
}
