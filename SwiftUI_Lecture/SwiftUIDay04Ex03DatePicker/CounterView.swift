//
//  CounterView.swift
//  SwiftUIDay04Ex03DatePicker
//
//  Created by 도민준 on 2/13/25.
//

import SwiftUI

struct CounterView: View {
    @State private var count = 0

    var body: some View {
        VStack {
            Text("Count: \(count)")
                .font(.largeTitle)
            Button("Increase") {
                count += 1
            }
            .padding()
            .background(Color.blue)
            .foregroundColor(.white)
            .cornerRadius(10)
        }
    }
}

struct CounterView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            CounterView()
                .previewDisplayName("Default State")
            CounterView()
                .environment(\.locale, .init(identifier: "ko"))
                .previewDisplayName("Korean Locale")
        }
    }
}
