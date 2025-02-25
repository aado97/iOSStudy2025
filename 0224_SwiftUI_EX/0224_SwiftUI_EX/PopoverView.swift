//
//  PopoverView.swift
//  0224_SwiftUI_EX
//
//  Created by 도민준 on 2/24/25.
//

import SwiftUI

struct PopoverView: View {
    @State private var showPopover = false

    var body: some View {
        Button("Show Popover") {
            showPopover = true
        }
        .popover(isPresented: $showPopover) {
            Text("Popover Content")
                .padding()
        }
    }
} 

#Preview {
    PopoverView()
}
