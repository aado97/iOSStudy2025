//
//  AlertView.swift
//  0224_SwiftUI_EX
//
//  Created by 도민준 on 2/24/25.
//


import SwiftUI

struct AlertView: View {
    @State private var showAlert = false

    var body: some View {
        Button("Show Alert") {
            showAlert = true
        }
        .alert("Alert Title", isPresented: $showAlert) {
            Button("OK", role: .cancel) { }
        }
    }
}

#Preview {
    AlertView()
}
