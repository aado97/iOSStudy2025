//
//  ContentView.swift
//  SwiftDayUI03Ex01
//
//  Created by 도민준 on 2/12/25.
//

import SwiftUI

struct ContentView: View {
    @State var message = "버튼을 클릭하세요"
    var body: some View {
        VStack(spacing: 20) {
            Text(message)
                .font(.title)
                .padding()
            
            Button(action: {
                message = "버튼이 클릭되었습니다."
            }) {
                Text("클릭하세요.")
                    .font(.headline)
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(Color.blue)
                    .foregroundColor(.white)
                    .cornerRadius(10)
            }
            .padding(.horizontal)
        }
    }
}

#Preview {
    ContentView()
}
