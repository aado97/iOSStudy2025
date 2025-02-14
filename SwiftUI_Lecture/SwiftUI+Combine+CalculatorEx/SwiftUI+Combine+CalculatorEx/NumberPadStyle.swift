//
//  NumberPadStyle.swift
//  SwiftUI+Combine+CalculatorEx
//
//  Created by 도민준 on 2/14/25.
//

import SwiftUI

// 커스텀 버튼 스타일 만들기
struct NumberPadStyle: ButtonStyle { // 버튼 스타일 프로토콜 공부하기
    private let color: Color
    
    init(color: Color) {
        self.color = color
    }
    
    // ButtonStyle로 커스텀 버튼 만들기 위한 필수 메서드?
    func makeBody(configuration: Configuration) -> some View {
        let wholeSpacing = AppConstant.UI.padSpacing * 5
        let screenWidth = UIScreen.size.width
        let size = (screenWidth - wholeSpacing) / 4
        configuration.label
            .frame(width: size, height: size, alignment: .center)
            .background(self.color)
            .clipShape(Circle())
            .font(.system(size: 30))
    }
}

/// 0 버튼 스타일
struct WidePadStyle: ButtonStyle {
    /// 버튼의 백그라운드 컬러
    private var color: Color
    
    init(color: Color) {
        self.color = color
    }
    
    func makeBody(configuration: Configuration) -> some View {
        let wholeSpacing = AppConstant.UI.padSpacing * 5
        let screenWidth = UIScreen.size.width
        let width = (screenWidth - wholeSpacing) / 2 + AppConstant.UI.padSpacing
        let height = (screenWidth - wholeSpacing) / 4
        configuration.label
            .frame(width: width, height: height, alignment: .center)
            .background(self.color)
            .clipShape(Capsule())
            .font(.system(size: 30))
    }
}


