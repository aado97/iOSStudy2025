//
//  CalculatorVM.swift
//  SwiftUI+Combine+CalculatorEx
//
//  Created by 도민준 on 3/7/25.
//

import SwiftUI
import Combine

class CalculatorViewModel: ObservableObject {
    @Published var number: String = "0"           // 현재 입력된 숫자
    @Published var resultNumber: Double = 0         // 계산 결과 값
    @Published var currentOperation: String? = nil  // 현재 선택된 연산자
    
    private var cancellables = Set<AnyCancellable>()
    
    // 계산 요청 이벤트 스트림
    private let calculateSubject = PassthroughSubject<Void, Never>()
    
    init() {
        // calculateSubject가 이벤트를 발행하면 calculateResult()를 실행.
        calculateSubject
            .sink { [weak self] in
                self?.calculateResult()
            }
            .store(in: &cancellables)
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
    
    // 결과 버튼 탭 시, calculateSubject를 통해 계산 요청.
    func tappedResult() {
        calculateSubject.send()
        currentOperation = nil // 연산 초기화
    }
    
    private func calculateResult() {
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
