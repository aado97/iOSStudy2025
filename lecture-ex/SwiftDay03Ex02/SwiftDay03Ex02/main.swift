//
//  main.swift
//  SwiftDay03Ex02
//
//  Created by 도민준 on 1/24/25.
//

import Foundation

/*
print("Hello, World!")

// 빈 배열 선언
var arr: [Int] = []
// 배열 리터럴을 이용해 초기화
let arr2: [Int] = [33,44,56,78]

// 배열의 맨 마지막 요소로 새 값 추가
arr.append(100) // arr[0]
arr.append(101) // arr[1]
arr.append(102) // arr[2]
arr.append(103) // arr[3]

// 배열의 전체 요소 확인

print(arr)
// for in문을 이용한 내용 확인
// 배열 요소의 수 만큼 자동 반복
for number in arr {
    print(number, terminator: " ")
}
print()

// 2번 index의 요소 제거 (at: 인덱스)
// 2번 index는 3번째 요소이다. (0부터 시작)
arr.remove(at: 2)
print(arr)

// 1번 index의 요소 확인, arr[3]는 현재 없다.
print(arr[1])
print("첨자로 배열 요소 접근하기", arr[0], arr[1], arr[2])

// 두 배열을 합쳐서 확인 하기
let resultArray: [Int] = arr2 + arr
print(resultArray)
*/

// 각 월의 날짜수를 저장한 배열.
let monthDays: [Int] = [31, 28, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31]
//              index  0   1   2   3   4   5   6   7   8   9   10  11
//              month  1   2   3   4   5   6   7   8   9   10  11  12
var month: Int = 0
var days: Int = 0

// 날짜 수를 알고자 하는 달 입력: 2
// 결과 2월 28일까지 있다.
//print("날짜 수를 알고자 하는 달 입력: ", terminator: "")
//month = Int(readLine() ?? "") ?? 0
//days = monthDays[month - 1]
//print("결과 \(month)월은 \(days)일까지 있다.")
//
//// monthDays를 이용해서 "1년은 365일까지 있다"는 것을 출력
// total변수에 monthDays의 모든 요소를 for in으로 누적
// var cnt = 1
// 인덱스와 요소를 같이 뽑아 온다.
// cnt = cnt + 1    <--- cnt += 1
/*
for (i, day) in monthDays.enumerated() {
    print("monthDays[\(i)] = \(day)")
}
*/

// 중요: 1) 반복해서 구현 해보기, 2) 머리를 믿지말고 그림을 그리기
// 생각이 바뀌면 행동이 바뀌고 행동이 바뀌면 습관이 된다. 습관이 바뀌면 운명이 바뀐다.
//
//var total = 0
//for i in 0 ..< monthDays.count {
//    total += monthDays[i]
//    print(i, i + 1, monthDays[i], total)
//}

// 문제1) 특정 월, 일을 입력 받아서 1월 1일부터 입력 된 월, 일까지의 누적 날짜 수 출력.
// 예)
// 월 입력: 4
// 일 입력: 10
// 1월 1일부터 4월 10일까지의 누적일은 100일 입니다.

//var afterDays = 0
//print("월 입력: ", terminator: "")
//month = Int(readLine() ?? "0") ?? 0
//print("일 입력: ", terminator: "")
//days = Int(readLine() ?? "0") ?? 0
//print("\(month)월 \(days)일 입니다.")
//
//for i in 1 ..< month{
//    afterDays += monthDays[i - 1]
//}
//
//afterDays += days
//
//print("1월 1일부터 \(month)월 \(days)일까지의 누적일은 \(afterDays)일 입니다.")

// 문제2) 월, 일을 입력 받아서 100일 후의 월, 일 출력. (난이도: 고)
// 월 입력: 11월
// 일 입력: 21
// 11월 21일의 100일 후는 0월 0일 입니다.


var afterDays = 100
while month < 1 || month > 12 {
    print("월 입력: ", terminator: "")
    month = Int(readLine() ?? "0") ?? 0
}
while days < 1 || days > monthDays[month - 1] {
    print("일 입력: ", terminator: "")
    days = Int(readLine() ?? "0") ?? 0
}
print("\(month)월 \(days)일의 \(afterDays)일 후는 ", terminator: "")

afterDays -= monthDays[month - 1] - days // 3월 arr[2]

if month < 12 {
    month += 1 // 4월
} else {
    month = 1
}

while afterDays > monthDays[month - 1] { //4월 arr[3]
    print("현재 \(month)월, 남은 \(afterDays)에서 \(monthDays[month - 1])를 뺀다")
    afterDays -= monthDays[month - 1]
    print("남은 \(afterDays)이다.")
    
    if month < 12 {
        month += 1
    } else {
        month = 1
    }
}

print("\(month)월 \(afterDays)일입니다.")


// -----
// Weekly Project 안내
// 다음 두가지 중 한가지만 수행해도 됩니다.
// 완성된 것은 TIL에 새 페이지를 만들어서 추가해주세요.
// 1) 전화번호부 구현 (입력, 출력, 검색, 수정, 삭제 기능)
// 2) 회고시스템 CRUD 기능 구현 (개선해서 만드는 것을 권장합니다.)
