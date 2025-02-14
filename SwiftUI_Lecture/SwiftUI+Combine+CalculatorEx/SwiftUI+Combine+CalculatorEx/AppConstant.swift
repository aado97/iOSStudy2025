//
//  AppConstant.swift
//  SwiftUI+Combine+CalculatorEx
//
//  Created by 도민준 on 2/14/25.
//

import UIKit

class AppConstant {
    class UI {}
    class UserdefaultsName {}
}

extension AppConstant.UI {
    /// 숫자 버튼간 여백
    static let padSpacing: CGFloat = 15
}

extension AppConstant.UserdefaultsName {
    /// 마지막 계산 값
    static let lastCalcValue: String = "lastCalcValue"
}
