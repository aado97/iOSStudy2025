//
//  PadView.swift
//  SwiftUI+Combine+CalculatorEx
//
//  Created by 도민준 on 2/14/25.
//

import SwiftUI

struct PadView: View {
    @Binding var number: String // 현재 입력된 숫자
    @Binding var resultNumber: Double // 계산 결과 값
    @State private var currentOperation: String? = nil
    
    // 숫자 버튼 간 여백
    private let spacing = AppConstant.UI.padSpacing
    
    var body: some View {
        VStack(spacing: self.spacing) {
            HStack(spacing: self.spacing) {
                Button("AC", action: { tappedAC() })
                    .buttonStyle(NumberPadStyle(color: .gray))
                Button("+/-", action: { tappedPlusMinus() })
                    .buttonStyle(NumberPadStyle(color: .gray))
                Button("%", action: { tappedPercent() })
                    .buttonStyle(NumberPadStyle(color: .gray))
                Button("÷", action: { tappedOperation("/") })
                    .buttonStyle(NumberPadStyle(color: .orange))
            }
            
            HStack(spacing: self.spacing) {
                Button("7", action: { tappedNumPad("7") })
                    .buttonStyle(NumberPadStyle(color: .brown))
                Button("8", action: { tappedNumPad("8") })
                    .buttonStyle(NumberPadStyle(color: .brown))
                Button("9", action: { tappedNumPad("9") })
                    .buttonStyle(NumberPadStyle(color: .brown))
                Button("✕", action: { tappedOperation("*") })
                    .buttonStyle(NumberPadStyle(color: .orange))
            }
            
            HStack(spacing: self.spacing) {
                Button("4", action: { tappedNumPad("4") })
                    .buttonStyle(NumberPadStyle(color: .brown))
                Button("5", action: { tappedNumPad("5") })
                    .buttonStyle(NumberPadStyle(color: .brown))
                Button("6", action: { tappedNumPad("6") })
                    .buttonStyle(NumberPadStyle(color: .brown))
                Button("-", action: { tappedOperation("-") })
                    .buttonStyle(NumberPadStyle(color: .orange))
            }
            
            HStack(spacing: self.spacing) {
                Button("1", action: { tappedNumPad("1") })
                    .buttonStyle(NumberPadStyle(color: .brown))
                Button("2", action: { tappedNumPad("2") })
                    .buttonStyle(NumberPadStyle(color: .brown))
                Button("3", action: { tappedNumPad("3") })
                    .buttonStyle(NumberPadStyle(color: .brown))
                Button("+", action: { tappedOperation("+") })
                    .buttonStyle(NumberPadStyle(color: .orange))
            }
            
            HStack(spacing: self.spacing) {
                Button("0", action: { tappedNumPad("0") })
                    .buttonStyle(WidePadStyle(color: .brown))
                Button(".", action: { tappedNumPad(".") })
                    .buttonStyle(NumberPadStyle(color: .brown))
                Button("=", action: { tappedResult() })
                    .buttonStyle(NumberPadStyle(color: .orange))
            }
        }
    }
    
    func tappedNumPad(_ num: String) {
        if self.number == "0" {
            self.number = num
        } else {
            self.number += num
        }
    }
    
    func tappedOperation(_ operation: String) {
        if let numberDouble = Double(self.number) {
            if currentOperation != nil {
                calculateResult() // 이전 연산을 처리
            } else {
                resultNumber = numberDouble
            }
            self.number = "0"
            currentOperation = operation
        }
    }
    
    func tappedResult() {
        calculateResult()
        currentOperation = nil // 연산 초기화
    }
    
    func calculateResult() {
        if let operation = currentOperation, let numberDouble = Double(self.number) {
            switch operation {
            case "+":
                resultNumber += numberDouble
            case "-":
                resultNumber -= numberDouble
            case "*":
                resultNumber *= numberDouble
            case "/":
                if numberDouble != 0 {
                    resultNumber /= numberDouble
                }
            default:
                break
            }
            self.number = String(resultNumber)
        }
    }
    
    func tappedAC() {
        self.number = "0"
        self.resultNumber = 0
        self.currentOperation = nil
    }
    
    func tappedPlusMinus() {
        if let number = Double(self.number) {
            self.number = String(-number)
        }
    }
    
    func tappedPercent() {
        if let number = Double(self.number) {
            self.number = String(number / 100)
        }
    }
}

//#Preview {
//    PadView(number: .constant("0"), resultNumber: .constant(0))
//}

struct PadView_Previews: PreviewProvider {
    static var previews: some View {
        PadView(number: .constant("0"), resultNumber: .constant(0))
    }
}

