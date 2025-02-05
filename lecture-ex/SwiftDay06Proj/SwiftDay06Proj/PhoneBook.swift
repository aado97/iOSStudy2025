//
//  PhoneBook.swift
//  SwiftDay06Proj
//
//  Created by 도민준 on 2/5/25.
//

import Foundation

class PhoneBook {
    let MENU_TITLE = "----- PHONE BOOK -----"
    let menuItems: [String] = ["INPUT", "OUTPUT", "SEARCH", "EDIT", "DELETE", "END"]
    var isDone: Bool = false

    var factory:[Any] = [Input(), Output(), Search(), Edit(), Delete(), End()]

    func paly() {
        var no = menu(menuItems: menuItems)
//        if let input = factory[0] as? Input {
//            input.run()
//        }

        if no == 1 {
            Input().run()
        }
        if no == 2 {
            Output().run()
        }
        if no == 3 {
            Search().run()
        }
        if no == 4 {
            Edit().run()
        }
        if no == 5 {
            Delete().run()
        }
        if no == 6 {
            End().run()
        }
    }

    func run() {
        while !isDone {
            paly()
        }
    }

    func menu(menuItems: [String]) -> Int {
        var no = 0
        repeat {
            print(MENU_TITLE);
            for (i, item) in menuItems.enumerated(){
                print("[\(i+1)]\(item)", terminator: " ")
            }
            print("\nChoice", terminator: ": ")
            no = Int(readLine() ?? "") ?? 0
        } while (no<1 || no>menuItems.count)

        return no
    }
}
