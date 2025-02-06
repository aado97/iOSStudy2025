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
    // let으로 선언하면 배열을 변경하거나 요소를 바꿀 수 없다.
    var shapeList: [Shape]
    
    init() {
        // init()함수의 목적은 초기화
        shapeList = [Circle(), Rectangle()]
    }
    
    func showList() {
        for shape in shapeList {
            shape.draw()
        }
    }
    
    func inputShape() {
        print("[1] Circle [2] Rectangel")
        guard let choice = readLine(), let intChoice = Int(choice) else {
            print("잘못 입력하셨습니다.")
            return
        }
        
        appendShape(choice: intChoice)
    }
    
    func showList(shapeList: [Shape]) {
        for shape in shapeList {
            shape.draw()
        }
    }

    // let을 var로 변경하면 수정 가능.
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
    
//    func appendShape(choice: Int, newShapeList: [Shape]) -> [Shape] {
//        // 함수형 프로그래밍 방식
//        var shape: Shape!
//        if choice == 1 {
//            shape = Circle()
//        }
//        if choice == 2 {
//            shape = Rectangle()
//        }
//        return newShapeList.count > 2 ? newShapeList + [shape] : shapeList + newShapeList + [shape]
//    }
    
    
    
    func main() {
        
        // 5회 반복 Shape 생성
        // 1번쨰 생성할 객체 타입 선택 (1)Circle (2)Rectangale : 1
        // 리스트에 Circle 객체 추가 완료 !
        // 2번쨰 생성할 객체 타입 선택 (1)Circle (2)Rectangale : 2
        // 리스트에 Rectangle 객체 추가 완료 !
        
        //var newShapeList: [Shape] = []
        
//        for i in 1...5 {
//            print("\(i)번째 생성할 객체 타입 선택 (1)Circle (2)Rectangale", terminator: ": ")
//            let choice: Int = Int(readLine() ?? "") ?? 0
//            appendShape(choice: choice)
//            //newShapeList = appendShape(choice: choice, newShapeList: newShapeList)
//        }
        
        // [1]입력 [2]목록 [3]종료
        // 선택: 1
        // [1]Circle [2]Rectangle
        // 선택: 2
        // Rectangle 추가 완료!
        
        while true {
            print("[1]입력 [2]목록 [3]종료")
            print("선택", terminator: ": ")
            let no = Int(readLine() ?? "") ?? 0
            if no == 1 {
                inputShape()
            }
            if no == 2 {
                showList()
            }
            if no == 3 {
                print("종료")
                break
            }
        }
        
        //showList(shapeList: newShapeList)
    }
}
