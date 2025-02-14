//
//  TextFieldExample.swift
//  SwiftUIDay04Ex03DatePicker
//
//  Created by 도민준 on 2/13/25.
//

import SwiftUI

struct TextFieldExample: View {
    @State private var name: String = ""
    @State private var email: String = ""
    
    var body: some View {
        VStack {
            HStack {
                Text("이름:")
                TextField("이름", text: $name)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .padding()
            }
            HStack {
                Text("이메일:")
                TextField("이메일", text: $email)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .keyboardType(.emailAddress)
                    .padding()
            }
            
            Text("입력한 이름: \(name)")
        }
        .padding()
    }
}

#Preview {
    TextFieldExample()
}
