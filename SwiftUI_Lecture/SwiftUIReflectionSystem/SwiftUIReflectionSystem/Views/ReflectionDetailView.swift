//
//  ReflectionDetailView.swift
//  SwiftUIReflectionSystem
//
//  Created by 도민준 on 2/14/25.
//

import SwiftUI

struct ReflectionDetailView: View {
    var reflection: Reflection
    
    var body: some View {
        VStack(alignment: .leading, spacing: 20) {
            Text(DateUtil.shared.formattedDate(reflection.date))
                .font(.title2)
            ZStack(alignment: .topLeading) {
                Rectangle()
                    .fill(Color(red: 1.00, green: 0.88, blue: 0.92))
                    .cornerRadius(10)
                    .shadow(color: Color.black.opacity(0.2), radius: 5, x: 3, y: 3)
                Text(reflection.content)
                    .font(.body)
                    .padding()
                Spacer()
            }
            
        }
        .padding()
        .navigationTitle("회고 상세")
    }
    
    
}

#Preview {
    ReflectionDetailView(reflection: Reflection(date: Date(), content: "ㅎㅇ"))
}
