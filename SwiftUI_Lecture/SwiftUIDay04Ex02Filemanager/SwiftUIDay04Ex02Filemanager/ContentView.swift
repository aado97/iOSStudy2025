//
//  ContentView.swift
//  SwiftUIDay04Ex02Filemanager
//
//  Created by 도민준 on 2/13/25.
//

import SwiftUI

struct ContentView: View {
    @State private var users: [User] = []
    
    var body: some View {
        Text("사용자 목록")
            .font(.largeTitle)
        VStack {
            List(users, id: \.id) { user in
                VStack(alignment: .leading) {
                    Text("이름: \(user.name)")
                    Text("나이: \(user.age)")
                }
            }
            Button(action: saveSampleUsers) {
                Text("샘플 데이터 저장")
                    .padding()
                    .background(Color.blue)
                    .foregroundColor(.white)
                    .cornerRadius(10)
            }
            Button(action: loadSavedUsers) {
                Text("저장된 데이터 불러오기")
                    .padding()
                    .background(Color.green)
                    .foregroundColor(.white)
                    .cornerRadius(10)
            }
        }
        .padding()
    }
    
    func saveSampleUsers() {
        let sampleUsers = [
            User(id: UUID(), name: "도민준", age: 29),
            User(id: UUID(), name: "도민준ㅋ", age: 29)
        ]
        FileManagerHelper.shared.saveUsers(sampleUsers)
    }
    
    func loadSavedUsers() {
        users = FileManagerHelper.shared.loadUsers()
    }
}

#Preview {
    ContentView()
}
