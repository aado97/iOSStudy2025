//
//  ToggleView.swift
//  SwiftUIDay04Ex03DatePicker
//
//  Created by 도민준 on 2/13/25.
//

import SwiftUI

struct ToggleView: View {
    @Binding var isOn: Bool

    var body: some View {
        Toggle(isOn: $isOn) {
            Text("Toggle Switch")
        }
        .padding()
    }
}

struct ToggleView_Previews: PreviewProvider {
    @State static var isOn = true

    static var previews: some View {
        ToggleView(isOn: $isOn)
    }
}
