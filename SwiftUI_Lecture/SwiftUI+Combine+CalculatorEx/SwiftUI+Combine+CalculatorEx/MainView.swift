//
//  ContentView.swift
//  SwiftUI+Combine+CalculatorEx
//
//  Created by 도민준 on 2/14/25.
//

import SwiftUI
import Combine

struct MainView: View {
    @State var number: String
    @State var resultNumber: Double
    
    var body: some View {
        GeometryReader { geometry in    // 현재 뷰가 차지할 수 있는 전체 크기(geometry.size)를 가져와서 레이아웃을 동적으로 조정
            VStack {
                Spacer()
                Text("\(self.number)")
                    // 텍스트의 너비를 화면 전체 크기로 설정
                    // 텍스트가 화면 오른쪽 정렬되도록 배치
                    .frame(width: geometry.size.width, alignment: .trailing)
                    .font(.system(size: 50))
                    .foregroundColor(.white)
                PadView(number: $number, resultNumber: $resultNumber)
            }.padding(.bottom, 30)
        }
        .preferredColorScheme(.dark)
    }
}

//#Preview {
//    MainView(number: .constant("0"), resultNumber: .constant(0))
//}


struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView(number: "0", resultNumber: 0)
    }
}

