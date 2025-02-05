//
//  FunctionEx02.swift
//  SwiftDay06
//
//  Created by 도민준 on 2/5/25.
//

import Foundation

struct FunctionEx02 {
    
    func run() {
        print("FunctionEx02.run()")
        
        // 다중 반환 값 예제
        let userInfo = getUserInfo()
        
//        lazy var name = userInfo.name
//        lazy var age = userInfo.age
        print("\(userInfo.name)님은 \(userInfo.age)세입니다.")
    }
}

extension FunctionEx02 {
    // 이름과 나이를 입력 받는 함수
    func getUserInfo() -> (name: String, age: Int) {
        print("성명", terminator: ": ")
        let name = readLine() ?? ""
        print("나이", terminator: ": ")
        let age = Int(readLine() ?? "") ?? 0
        
        return (name, age)
    }
}
