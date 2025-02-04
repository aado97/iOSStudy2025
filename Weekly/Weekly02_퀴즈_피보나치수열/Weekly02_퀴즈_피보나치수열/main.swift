//
//  main.swift
//  Weekly02_퀴즈_피보나치수열
//
//  Created by 도민준 on 2/3/25.
//

import Foundation

// 과제: Weekly Project는 다음 Project 전까지 계속 진행.
// 기본 과제: 배운것 TIL 정리(배운 것 + @)
// 퀴즈: 피보나치 수열 출력, 피보나치 수열에 부호 엇갈려서.
// 1 + 1 + 2 + 3 + 5 + 8 + 13 + 21
//var max = 21
//var prev = 0
//var cur = 1
//var next = 1
//var total = 0
//
//while cur <= max {
//    // 이전항과 현재항을 더해서 다음 항 만든다
//    next = prev + cur
//    // 현재항은 이전항으로 변경
//    prev = cur
//    // 다음항이 현재항으로 치환.
//    cur = next
//    // total에 이전항을 누적합.
//    total += prev
//    // 출력
//    print(prev, terminator: prev < max ? " + " : " = ")
//}
//
//print(total)

// 1 + 1 - 2 + 3 - 5 + 8 - 13 + 21
var max = 21
var prev = 0
var cur = 1
var next = 1
var total = 0
var cnt = 1

while cur <= max {
    // 이전항과 현재항을 더해서 다음 항 만든다
    next = prev + cur
    // 현재항은 이전항으로 변경
    prev = cur
    // 다음항이 현재항으로 치환.
    cur = next
    // count가 홀수일 경우
    if cnt % 2 == 1 {
        // 처음에는 total에 prev를 더하고
        if total == 0 {
            total = prev
        }
        else {
            // 그 이후부터 total에 이전항을 빼기.
            total -= prev
        }
        // 출력
        print(prev, terminator: prev < max ? " + " : " = ")
    } else {    // count가 짝수일 경우
        // total에 이전항을 더함.
        total += prev
        // 출력
        print(prev, terminator: prev < max ? " - " : " = ")
    }
    // 한주기 돌때마다 count에 1 더하기
    cnt += 1
}

print(total)
