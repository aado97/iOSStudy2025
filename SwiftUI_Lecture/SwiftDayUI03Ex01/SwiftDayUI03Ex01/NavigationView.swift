//
//  NavigationView.swift
//  SwiftDayUI03Ex01
//
//  Created by 도민준 on 2/12/25.
//

import SwiftUI

struct MainView: View {
    var body: some View {
        NavigationView {
            VStack(spacing: 20) {
                Text("메인화면")
                    .font(.title)
                    .padding(20)
                
                NavigationLink(destination: DetailView()) {
                    Text("세부 화면으로 이동")
                        .font(.headline)
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(Color.blue)
                        .foregroundColor(.white)
                        .cornerRadius(10)
                }
                .padding(.horizontal)
            }
            .navigationTitle("메인화면")
        }
    }
}

struct DetailView: View {
    var body: some View {
        VStack {
            Text("여기는 세부 화면입니다.")
                .font(.title)
                .padding()
            
            Spacer()
        }
        .navigationTitle("세부화면")
    }
}

#Preview {
    MainView()
}
