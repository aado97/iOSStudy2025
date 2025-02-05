//
//  FunctionEx03.swift
//  SwiftDay06
//
//  Created by 도민준 on 2/5/25.
//

import Foundation

struct FunctionEx03 {
    
    init() {
        // 객체(인스턴스)를 생성하면 바로 실행한다.
        // 멤버를 초기화 시키는 용도
        print("FunctionEx03 init 실행")
        
        // 옵셔널을 반환하는 함수 호출
        if let result = getName() {
            print("\(result)님 안녕하세요!")
        } else {
            print("유효하지 않습니다.")
        }
    }
}

extension FunctionEx03 {
    
    func getName() -> String? {
        return nil
    }
}
