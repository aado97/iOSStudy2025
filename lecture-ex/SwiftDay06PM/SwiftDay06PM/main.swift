//
//  main.swift
//  SwiftDay06PM
//
//  Created by 도민준 on 2/5/25.
//

import Foundation

/*
let numbers: [Int] = [4, 5, 3, 1, 2]

print(numbers)

let newNumbers: [Int] = numbers.map { $0 * 3 }
print(newNumbers)

let sortedArr = numbers.sorted { $0 < $1 }

print(sortedArr)

// 원래 배열은 변함 없다.
print(numbers)
*/

let numbers: [Int] = [4, 5, 3, 1, 2]
print(numbers)

func triple(num: Int) -> Int {
    return num * 3
}
let newNumbers: [Int] = numbers.map(triple)
print(newNumbers)

func mysort(a: Int, b: Int) -> Bool {
    return a < b
}
let sortedArr = numbers.sorted(by: mysort)
print(sortedArr)
