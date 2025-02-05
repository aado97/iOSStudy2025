//
//  FunctionEx.swift
//  SwiftDay06
//
//  Created by 도민준 on 2/5/25.
//

struct FunctionEx {
    func run() {
        
        print("run FunctionEx")
        example01(title: "더하기 예제")
        
    }
}

extension FunctionEx {
    
    func example01(title: String) {
        print("첫번쨰 예제는 \(title)입니다.")
        
        let value1 = 100
        let value2 = 150
        let total = add(x: value1, y: value2)
        print("\(value1) 더하기 \(value2)는 \(total)입니다.")
    }
    
    func add(x: Int, y: Int) -> Int {
        let sum = x + y
        return sum
    }
}
