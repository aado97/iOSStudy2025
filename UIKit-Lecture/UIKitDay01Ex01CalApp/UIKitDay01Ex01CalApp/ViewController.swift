//
//  ViewController.swift
//  UIKitDay01Ex01CalApp
//
//  Created by 도민준 on 2/25/25.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var num1txtField: UITextField!
    @IBOutlet weak var num2txtField: UITextField!
    
    @IBOutlet weak var operatortxtField: UITextField!
    
    
    @IBOutlet weak var lblResult: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        
    }
    
    @IBAction func resultBtnTapped(_ sender: UIButton) {
        result()
    }
    
    func result() {
        var num1 = Int(num1txtField.text ?? "") ?? 0
        var num2 = Int(num2txtField.text ?? "") ?? 0
        
        var operatorText = operatortxtField.text ?? "+"
        
        var result: Int
        
        switch operatorText {
        case "+":
            result = addNum(num1: num1, num2: num2)
        case "-":
            result = subtractNum(num1: &num1, num2: &num2)
        default:
            return
        }
        
        lblResult.text = "결과 : \(result)"
    }
    
    
    func addNum(num1: Int, num2: Int) -> Int {
        var result = num1 + num2
        return result
    }
    
    func subtractNum(num1: inout Int, num2: inout Int) -> Int {
        if num1 < num2 {
            swap(&num1, &num2)
        }
        var result = num1 - num2
        return result
    }
    
    


}

