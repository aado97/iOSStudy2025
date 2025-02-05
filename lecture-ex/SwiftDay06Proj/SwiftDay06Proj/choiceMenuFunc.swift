//
//  choiceMenuFunc.swift
//  SwiftDay06Proj
//
//  Created by 도민준 on 2/5/25.
//

import Foundation

struct choiceMenuFunc{
    var menuList = """
            ----- MENU -----
            1)INPUT 2)OUTPUT 3)SEARCH 4)EDIT 5)DELETE 6)END
            """
    func choiceMenu() {
        while true {
            print(menuList)
            print("Choice", terminator: ": ")
            let menuNum = Int(readLine() ?? "") ?? 0
            
            if menuNum == 6 {
                print("----- 종료 -----")
                break
            }
            
            switch menuNum {
            case 1:
                print("----- 입력 기능 -----")
            case 2:
                print("----- 목록 출력 기능 -----")
            case 3:
                print("----- 이름 검색 기능 -----")
            case 4:
                print("----- 수정 기능 -----")
            case 5:
                print("----- 삭제 기능 -----")
            default:
                print("유효하지 않은 메뉴입니다.")
            }
        }
    }
}
