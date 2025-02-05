//
//  main.swift
//  SwiftDay06
//
//  Created by 도민준 on 2/5/25.
//

import Foundation

print("Hello, World!")

// 1. 구조체 객체를 선언
// 2. 함수 호출

print("실행 예제 번호 입력", terminator: ": ")
let no = Int(readLine() ?? "") ?? 0

if no == 1 {
    // 객체 참조 변수를 이용해서 호출
    let ex01 = FunctionEx()
    ex01.run()
}
if no == 2 {
    // 객체를 선언과 동시에 바로 호출
    FunctionEx02().run()
}
if no == 3 {
    // 객체를 선언과 동시에 바로 호출
    FunctionEx03()
}
