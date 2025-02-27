//
//  SwiftUI_Combine_CalculatorExApp.swift
//  SwiftUI+Combine+CalculatorEx
//
//  Created by 도민준 on 2/14/25.
//

import SwiftUI

@main
struct SwiftUI_Combine_CalculatorExApp: App {
    @State private var number: String = "0" // 현재 입력된 숫자 저장
    @State private var resultNumber: Double = UserDefaults.standard.double(forKey: AppConstant.UserdefaultsName.lastCalcValue) // 계산 결과 저장
    
    var body: some Scene {
        WindowGroup {
            MainView(number: number, resultNumber: resultNumber) // `@Binding`으로 전달
        }
    }
}
