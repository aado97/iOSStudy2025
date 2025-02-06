//
//  main.swift
//  SwiftDay07LectureOOP
//
//  Created by 도민준 on 2/6/25.
//

import Foundation

/*
// 객체를 생성하고 멤버함수 호출
let sonata = Car(color: "검정색", speed: 110)
let grandeur = Car(color: "하얀색", speed: 120)

// 리스트에 넣을 수 있나?
let carList: [Car] = [sonata, grandeur]
let carList2: [Car] = [Car(color: "보라색", speed: 110), Car(color: "파랑색", speed: 130)]

//sonata.drive()
//grandeur.drive()
for car in carList {
    car.drive()
}

for (i, car) in carList2.enumerated() {
    print(i, terminator: ": ")
    car.drive()
}
*/

var shapes: [Shape] = [Circle(), Rectangle()]

for i in shapes {
    i.draw()
}
