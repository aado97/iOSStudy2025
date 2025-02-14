//
//  SwiftUI_Combine_CalculatorExApp.swift
//  SwiftUI+Combine+CalculatorEx
//
//  Created by 도민준 on 2/14/25.
//

import SwiftUI

@main
struct SwiftUI_Combine_CalculatorExApp: App {
    // UserDefault로 저장, 간단한 데이터라 그런듯?
    let initValue = UserDefaults.standard.double(forKey: AppConstant.UserdefaultsName.lastCalcValue) ?? 0
    var body: some Scene {
        WindowGroup {
            MainView(number: .constant(self.initValue))
        }
    }
}
