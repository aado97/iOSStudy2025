//
//  main.swift
//  SwiftDay07LectureOOP
//
//  Created by 도민준 on 2/6/25.
//

import Foundation

//let shapeView = ShapeView()
//shapeView.main()

// 클래스 정의
class Person {
    var name: String
    
    init(name: String) {
        self.name = name
    }
}

// 구조체 정의
struct Animal {
    var type: String
}

// 클래스 인스턴스 생성
let person1 = Person(name: "Alice")
let person2 = person1
person2.name = "Bob"

print(person1.name)     // 출력: Bob (참조 타입)

// 구조체 인스턴스 생성
var animal1 = Animal(type: "Cat")
var animal2 = animal1
animal2.type = "Dog"

print(animal1.type)     // 출력: Cat (값타입)
