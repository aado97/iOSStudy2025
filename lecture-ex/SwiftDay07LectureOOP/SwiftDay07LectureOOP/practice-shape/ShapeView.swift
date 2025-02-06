//
//  ShapeView.swift
//  SwiftDay07LectureOOP
//
//  Created by 도민준 on 2/6/25.
//

import Foundation



class ShapeView {
    // Array 선언
    // 빈 배열 생성
    // let shapeList = [Shape]()
    // 선언과 동시에 초기화
    // let shapeList = [Circle(), Rectangle(), Circle(), Circle()]
    // 빈 배열에 데이터 추가: append() 사용.
    var shapeList: [Shape] = []
    
    func showList() {
        for shape in shapeList {
            shape.draw()
        }
    }
    
    func appendShape(choice: Int) {
        switch choice {
        case 1:
            shapeList.append(Circle())
            print("리스트에 Circle 객체 추가 완료 !")
        case 2:
            shapeList.append(Rectangle())
            print("리스트에 Rectangle 객체 추가 완료 !")
        default:
            print("잘못된 입력입니다.")
        }
    }
    
    func main() {
        
        // 5회 반복 Shape 생성
        // 1번쨰 생성할 객체 타입 선택 (1)Circle (2)Rectangale : 1
        // 리스트에 Circle 객체 추가 완료 !
        // 2번쨰 생성할 객체 타입 선택 (1)Circle (2)Rectangale : 2
        // 리스트에 Rectangle 객체 추가 완료 !
        
        for i in 1...5 {
            print("\(i)번째 생성할 객체 타입 선택 (1)Circle (2)Rectangale", terminator: ": ")
            let choice: Int = Int(readLine() ?? "") ?? 0
            appendShape(choice: choice)
        }
        
        showList()
    }
}
