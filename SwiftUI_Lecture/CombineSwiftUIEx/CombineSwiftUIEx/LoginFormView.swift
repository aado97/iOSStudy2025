//
//  LoginFormView.swift
//  CombineSwiftUIEx
//
//  Created by 도민준 on 2/15/25.
//

import SwiftUI
import Combine

class FormModel: ObservableObject {
    @Published var username = ""
    @Published var password = ""
}

struct LoginFormView: View {
    @StateObject private var formModel = FormModel()

    var body: some View {
        VStack {
            TextField("Username", text: $formModel.username)
                .textFieldStyle(RoundedBorderTextFieldStyle())
            SecureField("Password", text: $formModel.password)
                .textFieldStyle(RoundedBorderTextFieldStyle())
          Text("Login Button Enabled: \(isLoginButtonEnabled ? "Yes" : "No")")
        }
        .padding()
    }

    var isLoginButtonEnabled: Bool {
        !formModel.username.isEmpty && !formModel.password.isEmpty
    }
}



#Preview {
    LoginFormView()
}
