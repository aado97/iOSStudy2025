//
//  NestedLayout.swift
//  SwiftUIDay02_Ex01
//
//  Created by 도민준 on 2/11/25.
//

import SwiftUI

struct NestedLayout: View {
    var body: some View {
        VStack(spacing: 20) {  // 전체 레이아웃을 VStack으로 구성
                    // HStack으로 "이름: 김범준" 텍스트 배치
                    HStack {
                        Text("이름:")
                            .font(.headline)
                        Text("도민준")
                            .font(.body)
                    }
                    .padding()
                    .background(Color.yellow.opacity(0.3))  // 배경색 확인을 위해 연한 노란색
                    
                    // ZStack으로 회색 배경에 텍스트 표시
                    ZStack {
                        Color.gray  // 회색 배경
                        Text("중첩된 ZStack")
                            .foregroundColor(.white)  // 텍스트 색상을 흰색으로 설정
                            .font(.title)
                    }
                    .frame(height: 100)  // ZStack의 높이 지정
                    .cornerRadius(10)  // 모서리를 둥글게 설정
                }
                .padding()
    }
}

#Preview {
    NestedLayout()
}
