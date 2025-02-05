//
//  Example.swift
//  SwiftDay06PM
//
//  Created by 도민준 on 2/5/25.
//

import Foundation

struct Example {
    func ex01() {
        // 테스트.
        // 가설 - 변수에 함수를 참조?

        // 함수를 선언한다.
        func myFunc() {
            print("myFunc 호출")
        }

        // 함수를 호출한다.
        myFunc()

        // 변수에 함수를 담아본다(참조)
        var refFunc = myFunc

        // 증명 - 변수에 함수를 참조 가능하다.
        refFunc()
    }
    
    func ex02() {
        // 함수의 기본적인 형태
        func mult (a: Int, b: Int) -> Int {
            let result = a * b
            return result
        }

        // 클로저(익명함수)로 구현
        // { (매개변수) -> 리턴형 in 처리 }
        let multiply = { (a: Int, b: Int) -> Int in a * b }
        // 클로저 호출 - 매개변수 라벨 생략(주의)
        let result = multiply(5, 3)
        print(result)
    }
    
    func ex03() {
        let numbers: [Int] = [4, 5, 3, 1, 2]

        print(numbers)

        let newNumbers: [Int] = numbers.map { $0 * 3 }
        print(newNumbers)

        let sortedArr = numbers.sorted { $0 < $1 }

        print(sortedArr)

        // 원래 배열은 변함 없다.
        print(numbers)
    }
}
