//
//  ActionSheetViewEx.swift
//  SwiftDayUI03Ex02
//
//  Created by 도민준 on 2/12/25.
//

import SwiftUI

struct ActionSheetViewEx: View {
    @State private var showActionSheet = false
    
    var body: some View {
        Button("showActionSheet") {
            showActionSheet = true
        }
        .actionSheet(isPresented: $showActionSheet) {
            ActionSheet(
                title: Text("Select Option"),
                buttons: [
                    .default(Text("Option 1")),
                    .destructive(Text("Delete")),
                    .cancel()
                ])
        }
    }
}

#Preview {
    ActionSheetViewEx()
}
