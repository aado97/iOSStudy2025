//
//  ActionSheetView.swift
//  0224_SwiftUI_EX
//
//  Created by 도민준 on 2/24/25.
//

import SwiftUI

struct ActionSheetView: View {
    @State private var showActionSheet = false

    var body: some View {
        Button("Show ActionSheet") {
            showActionSheet = true
        }
        .actionSheet(isPresented: $showActionSheet) {
            ActionSheet(
                title: Text("Select Option"),
                buttons: [
                    .default(Text("Option 1")),
                    .destructive(Text("Delete")),
                    .cancel()
                ]
            )
        }
    }
}

#Preview {
    ActionSheetView()
}
