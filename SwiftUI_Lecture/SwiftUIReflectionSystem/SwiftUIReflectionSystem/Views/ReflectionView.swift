//
//  ReflectionView.swift
//  SwiftUIReflectionSystem
//
//  Created by 도민준 on 2/14/25.
//

import SwiftUI

struct ReflectionView: View {
    @State private var content: String = ""
    @EnvironmentObject var viewModel: ReflectionViewModel
    
    var body: some View {
        VStack {
            TextEditor(text: $content)
                .frame(height: 200)
                .border(Color.gray)
                .padding()
            
            Button("저장하기") {
                let newReflection = Reflection(date: Date(),  content: content)
                viewModel.reflections.append(newReflection)
                viewModel.saveReflection()
                content = ""
            }
            .padding()
            .background(Color.blue)
            .foregroundColor(.white)
            .cornerRadius(10)
        }
        .padding()
    }
}

#Preview {
    ReflectionView()
}
