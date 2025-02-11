//
//  Practice.swift
//  SwiftUIDay02_Ex01
//
//  Created by 도민준 on 2/11/25.
//

import SwiftUI

struct Practice: View {
    var body: some View {
        Text("패딩먼저")
            .padding()                    // ✅ 여백이 있는 상태로 배경 적용
            .background(Color.yellow)      // 전체 영역이 배경색으로 채워짐
        Text("백그라운드 먼저")
            .background(Color.yellow)      // 텍스트 부분만 배경 적용
            .padding()                     // 텍스트 주위에 여백 추가
        Text("줄 간격 설정 예제\nSwiftUI는 재미있어요!")
            .multilineTextAlignment(.center)  // 중앙 정렬
            .lineSpacing(10)                  // 줄 간격 설정
        Text("밑줄 텍스트")
            .underline()
        Text("취소선 텍스트")
            .strikethrough()
        Text("Dynamic Type 지원")
            .dynamicTypeSize(.large)
    }
}

#Preview {
    Practice()
}
