//
//  ActionSheetExample.swift
//  0224_SwiftUI_EX
//
//  Created by 도민준 on 2/24/25.
//

import SwiftUI

struct ActionSheetExample: View {
    @State private var showActionSheet = false

    var body: some View {
        Button("Show ActionSheet") {
            showActionSheet = true
        }
        .actionSheet(isPresented: $showActionSheet) {
            ActionSheet(
                title: Text("Options"),
                message: Text("Choose an option"),
                buttons: [
                    .default(Text("Option 1")) { print("Option 1 selected") },
                    .destructive(Text("Delete")) { print("Delete selected") },
                    .cancel()
                ]
            )
        }
    }
}
#Preview {
    ActionSheetExample()
}
