//
//  SwiftUI_Combine_CalculatorExApp.swift
//  SwiftUI+Combine+CalculatorEx
//
//  Created by 도민준 on 2/14/25.
//

import SwiftUI

@main
struct SwiftUI_Combine_CalculatorExApp: App {
    @StateObject var viewModel = CalculatorViewModel()
    
    var body: some Scene {
        WindowGroup {
            MainView(viewModel: viewModel)
        }
    }
}
