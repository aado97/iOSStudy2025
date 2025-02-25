//
//  ConfirmationDialogExample.swift
//  0224_SwiftUI_EX
//
//  Created by 도민준 on 2/24/25.
//

import SwiftUI

struct ConfirmationDialogExample: View {
    @State private var showDialog = false

    var body: some View {
        Button("Show ConfirmationDialog") {
            showDialog = true
        }
        .confirmationDialog("Options", isPresented: $showDialog) {
            Button("Option 1") { print("Option 1 selected") }
            Button("Delete", role: .destructive) { print("Delete selected") }
            Button("Cancel", role: .cancel) { }
        } message: {
            Text("Choose an option")
        }
    }
}


#Preview {
    ConfirmationDialogExample()
}
