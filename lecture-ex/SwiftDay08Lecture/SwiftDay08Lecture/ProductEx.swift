//
//  ProductEx.swift
//  SwiftDay08Lecture
//
//  Created by 도민준 on 2/7/25.
//

import Foundation

protocol Product {
    // 내부 구현 override 용
    func info()
}

extension Product {
    // 외부 호출용
    func displayInfo() {
        info()
    }
}

class Car: Product {
    var brand: String
    var model: String
    
    // 필드의 초기화 함수
    init(name: String, maker: String) {
        self.brand = name
        self.model = maker
    }
    
    func info() {
        print(brand, model)
    }
}

class Book: Product {
    var title: String
    var author: String
    
    init(name: String, maker: String) {
        self.title = name
        self.author = maker
    }
    
    func info() {
        print(title, author)
    }
}

func productExRun() {
    //    let car: Product = Car(name: "aaa", maker: "aaaModel")
    //    let book: Product = Book(name: "bbb", maker: "bbbAuthor")
    //
    //    car.displayInfo()
    //    book.displayInfo()
    
    var productList: [Product] = [Car(name: "ccc", maker: "cccModel"),
                                  Book(name: "ddd", maker: "ddddModel")]
    for product in productList {
        product.displayInfo()
    }
}
