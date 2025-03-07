//
//  PadView.swift
//  SwiftUI+Combine+CalculatorEx
//
//  Created by 도민준 on 2/14/25.
//

import SwiftUI

struct PadView: View {
    @ObservedObject var viewModel: CalculatorViewModel
    
    // 숫자 버튼 간 여백
    private let spacing = AppConstant.UI.padSpacing
    
    var body: some View {
        VStack(spacing: self.spacing) {
            HStack(spacing: spacing) {
                Button("AC") { viewModel.tappedAC() }
                    .buttonStyle(NumberPadStyle(color: .gray))
                Button("+/-") { viewModel.tappedPlusMinus() }
                    .buttonStyle(NumberPadStyle(color: .gray))
                Button("%") { viewModel.tappedPercent() }
                    .buttonStyle(NumberPadStyle(color: .gray))
                Button("÷") { viewModel.tappedOperation("/") }
                    .buttonStyle(NumberPadStyle(color: .orange))
            }
            
            HStack(spacing: spacing) {
                Button("7") { viewModel.tappedNumPad("7") }
                    .buttonStyle(NumberPadStyle(color: .brown))
                Button("8") { viewModel.tappedNumPad("8") }
                    .buttonStyle(NumberPadStyle(color: .brown))
                Button("9") { viewModel.tappedNumPad("9") }
                    .buttonStyle(NumberPadStyle(color: .brown))
                Button("✕") { viewModel.tappedOperation("*") }
                    .buttonStyle(NumberPadStyle(color: .orange))
            }
            
            HStack(spacing: spacing) {
                Button("4") { viewModel.tappedNumPad("4") }
                    .buttonStyle(NumberPadStyle(color: .brown))
                Button("5") { viewModel.tappedNumPad("5") }
                    .buttonStyle(NumberPadStyle(color: .brown))
                Button("6") { viewModel.tappedNumPad("6") }
                    .buttonStyle(NumberPadStyle(color: .brown))
                Button("-") { viewModel.tappedOperation("-") }
                    .buttonStyle(NumberPadStyle(color: .orange))
            }
            
            HStack(spacing: spacing) {
                Button("1") { viewModel.tappedNumPad("1") }
                    .buttonStyle(NumberPadStyle(color: .brown))
                Button("2") { viewModel.tappedNumPad("2") }
                    .buttonStyle(NumberPadStyle(color: .brown))
                Button("3") { viewModel.tappedNumPad("3") }
                    .buttonStyle(NumberPadStyle(color: .brown))
                Button("+") { viewModel.tappedOperation("+") }
                    .buttonStyle(NumberPadStyle(color: .orange))
            }
            
            HStack(spacing: spacing) {
                Button("0") { viewModel.tappedNumPad("0") }
                    .buttonStyle(WidePadStyle(color: .brown))
                Button(".") { viewModel.tappedNumPad(".") }
                    .buttonStyle(NumberPadStyle(color: .brown))
                Button("=") { viewModel.tappedResult() }
                    .buttonStyle(NumberPadStyle(color: .orange))
            }
        }
    }
    
    
}

//#Preview {
//    PadView(number: .constant("0"), resultNumber: .constant(0))
//}

struct PadView_Previews: PreviewProvider {
    static var previews: some View {
        PadView(viewModel: CalculatorViewModel())
    }
}

